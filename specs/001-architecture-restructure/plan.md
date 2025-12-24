# Implementation Plan: architecture-restructure

**Branch**: `001-architecture-restructure` | **Date**: 2025-12-16 | **Spec**: [specs/001-architecture-restructure/spec.md](specs/001-architecture-restructure/spec.md)
**Input**: Feature specification from `/specs/001-architecture-restructure/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Refactor the Flutter app to MLH-grade quality by enforcing SOLID layering, centralized Navigator 1.0 routing, a design system with reusable UI components, and focused showcase refactors for Login/Auth and Booking flows. Add CI (format/analyze/test), tests, and a curated `mlh-code-sample` branch while keeping the existing `lib/` top-level structure.

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: Dart 3.5.x; Flutter 3.x (mobile)
**Primary Dependencies**: flutter_bloc (Cubit), dio, flutter_dotenv, get_it (if needed for manual locator), mocktail (tests)
**Storage**: Local cache via cache_helper (shared_prefs-style)
**Testing**: flutter test (unit/widget), mocktail
**Target Platform**: Android, iOS (Web out of scope)
**Project Type**: Mobile app (single Flutter project)
**Performance Goals**: Smooth UI at 60 fps; avoid unnecessary rebuilds in key flows
**Constraints**: No secrets committed; configs via .env.example / --dart-define; Navigator 1.0 only; snake_case assets; minimal DI complexity
**Scale/Scope**: Moderate app (doctor/parent flows); focus on two showcase flows + shared UI/design system

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- Plan exists before any refactor; follow Audit → Plan → Implement.
- Preserve lib layout (core/, doctor/, parent/, shared/, main.dart); additions only `lib/app/`, `lib/core/design_system/`, `lib/core/ui/` plus optional /docs, /specs, .github.
- Routing: single Navigator 1.0 route table under `lib/app/router/` (or equivalent); no go_router; route names centralized with safe fallback.
- Design system: tokens in `lib/core/design_system/`; reusable components in `lib/core/ui/**`; migrate away from inline styling.
- Layering: UI → Cubit/Controller → Usecase/Service → Repository → Datasource; no networking/parsing in UI/cubits; DI manual in one place.
- Platforms: Android + iOS only (Web out of scope).
- Security/hygiene: no secrets committed; use .env.example/--dart-define; filenames snake_case; remove commented-out code; keep main.dart minimal bootstrap.
- Quality gates: `dart format --set-exit-if-changed .`, `flutter analyze`, `flutter test` must pass.
- Branching/story: curated `mlh-code-sample` branch with Conventional Commits; keep repo working between commits.

## Project Structure

### Documentation (this feature)

```text
specs/001-architecture-restructure/
├── plan.md              # This file (/speckit.plan output)
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/           # Phase 1 output (openapi.yaml)
└── tasks.md             # Phase 2 output (/speckit.tasks later)
```

### Source Code (repository root)
<!--
  ACTION REQUIRED: Replace the placeholder tree below with the concrete layout
  for this feature. Delete unused options and expand the chosen structure with
  real paths (e.g., apps/admin, packages/something). The delivered plan must
  not include Option labels.
-->

```text
lib/
├── app/
│   └── router/
│       └── app_router.dart
├── core/
│   ├── design_system/
│   │   ├── tokens/
│   │   │   ├── colors.dart
│   │   │   ├── typography.dart
│   │   │   ├── spacing.dart
│   │   │   └── radius.dart
│   │   └── theme.dart
│   ├── ui/
│   │   ├── buttons/app_button.dart
│   │   ├── text_fields/app_text_field.dart
│   │   ├── search/app_search_field.dart
│   │   ├── cards/app_card.dart
│   │   ├── app_bar/app_header.dart
│   │   └── states/
│   │       ├── loading_view.dart
│   │       ├── error_view.dart
│   │       └── empty_view.dart
│   ├── network/
│   │   ├── api_constants.dart
│   │   ├── dio_factory.dart
│   │   └── dio_helper.dart
│   ├── cache/
│   └── (existing utils/models)
├── doctor/
├── parent/
│   └── find_doctors/
│       └── booking/
├── shared/
│   └── auth/
└── main.dart
```

**Structure Decision**: Single Flutter app; keep existing feature folders; add only `lib/app/router/`, `lib/core/design_system/`, and `lib/core/ui/` per constraints.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|---------------------------------------|
| None | N/A | N/A |
