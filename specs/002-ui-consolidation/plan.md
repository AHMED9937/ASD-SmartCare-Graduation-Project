# Implementation Plan: UI Component System Consolidation (002)

**Branch**: `002-ui-consolidation` | **Date**: 2025-12-16 | **Spec**: [specs/002-ui-consolidation/spec.md](specs/002-ui-consolidation/spec.md)
**Input**: Consolidate and reorganize UI component system by moving legacy widgets from lib/core/widgets/layouts to lib/core/ui with redesign improvements

## Summary

This plan consolidates the fragmented UI component system in ASD SmartCare by migrating legacy reusable components from `lib/core/widgets/layouts/` into the organized `lib/core/ui/` directory structure with design improvements (design tokens, responsive layouts, proper variants). Simultaneously, application state management files (`AppCubit`, `AppState`, `BlocObserver`) will be reorganized into a new `lib/core/state/` directory to maintain clean separation of concerns. Feature-specific components will be moved to their respective feature folders. This creates a unified, well-organized component library that serves as the foundation for 003-screen-audit refactoring efforts.

## Technical Context

**Language/Version**: Dart 3.5.x with Flutter 3.x framework  
**Primary Dependencies**: flutter_bloc (Cubit pattern with sealed classes), flutter, dart:async  
**Storage**: Local files (no database; state via Cubit/BLoC)  
**Testing**: flutter test with widget_test + unit tests (90+ existing tests must pass)  
**Target Platform**: Mobile (Android 7.0+, iOS 12.0+); Web out of scope  
**Project Type**: Multi-feature mobile app with centralized design system  
**Performance Goals**: Component instantiation <100ms, responsive layout adaptation for 320–1200dp width ranges  
**Constraints**: No breaking changes to public API during migration; 100% backward compatibility or clear deprecation path; zero hardcoded styling  
**Scale/Scope**: 8–12 reusable component subdirectories, 5 legacy components to consolidate, 50+ screens to gradually refactor (in 002), 20+ public component exports

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

✅ **Plan exists before any refactor**: YES - This plan precedes implementation following Audit → Plan → Implement principle.

✅ **Preserve lib layout**: YES - No changes to `lib/core/`, `lib/doctor/`, `lib/parent/`, `lib/shared/`, `main.dart`. Additions only: `lib/core/ui/containers/` (new subdirectory in existing ui), `lib/core/state/` (new top-level core directory for state management).

✅ **Routing unchanged**: YES - No routing changes; Navigator 1.0 via `lib/app/router/` remains unchanged.

✅ **Design system tokens**: YES - Components will migrate to use tokens from `lib/core/design_system/` (AppColors, AppSpacing, AppTypography, AppRadius) instead of hardcoded values.

✅ **Layering enforced**: YES - UI components in `lib/core/ui/` are presentation-only (no networking, parsing, state); state management moved to `lib/core/state/`; feature-specific components moved to feature folders.

✅ **Platforms in scope**: YES - Android + iOS only; Web out of scope.

✅ **Security/hygiene**: YES - No secrets; filenames snake_case; commented-out code will be removed; main.dart unchanged.

✅ **Quality gates**: YES - All outputs must pass `dart format`, `flutter analyze`, `flutter test` (90+ existing tests must continue passing).

✅ **Branching/curated**: YES - Branch `002-ui-consolidation` with Conventional Commits; repo remains working between commits.

**Gate Result**: ✅ **PASS** - Plan complies with all constitution principles. No violations detected.

## Project Structure

### Documentation (this feature)

```text
specs/002-ui-consolidation/
├── plan.md              # This file (implementation planning)
├── spec.md              # Feature specification
├── research.md          # [Phase 0 - To be generated] Technical research & design decisions
├── data-model.md        # [Phase 1 - To be generated] Component inventory & migration targets
├── quickstart.md        # [Phase 1 - To be generated] Developer onboarding for new component system
├── contracts/           # [Phase 1 - To be generated] Component API contracts (minimal for Dart)
└── tasks.md             # [Phase 2 - Not created by /speckit.plan] Detailed task breakdown
```

### Source Code (repository root)

**Existing Structure (Preserved)**:
```text
lib/
├── app/router/          # Routing (unchanged)
├── core/
│   ├── design_system/   # Tokens: AppColors, AppSpacing, AppTypography, AppRadius (unchanged)
│   ├── ui/              # Reusable UI Components (TO BE CONSOLIDATED)
│   │   ├── app_bar/
│   │   ├── buttons/     # [CONSOLIDATE] legacy app_buttons.dart → buttons/
│   │   ├── cards/
│   │   ├── search/
│   │   ├── states/
│   │   ├── text_fields/ # [CONSOLIDATE] legacy text field components → text_fields/
│   │   ├── containers/  # [NEW] Layout utilities (from fixed_widgets.dart)
│   │   └── ui.dart      # Central export (REGENERATE with all exports)
│   ├── widgets/         # [DEPRECATION] App state (app_cubit, app_state, bloc_observer) TO MOVE
│   │   ├── app_cubit.dart        # [MOVE to lib/core/state/]
│   │   ├── app_state.dart        # [MOVE to lib/core/state/]
│   │   ├── bloc_observer.dart    # [MOVE to lib/core/state/]
│   │   └── layouts/     # [DELETE] Legacy components (to be migrated)
│   │       ├── app_buttons.dart
│   │       ├── app_form_text_field.dart
│   │       ├── stateless_app_text_form_field.dart
│   │       ├── fixed_widgets.dart
│   │       └── ReviewSpacificDoctor/
│   ├── state/           # [NEW] Application State Management (from widgets/)
│   │   ├── app_cubit.dart
│   │   ├── app_state.dart
│   │   └── bloc_observer.dart
│   ├── cache/           # (unchanged)
│   ├── errors/          # (unchanged)
│   ├── models/          # (unchanged)
│   ├── network/         # (unchanged)
│   ├── theme/           # (unchanged)
│   └── utils/           # (unchanged)
├── doctor/              # Feature module (unchanged)
├── parent/              # Feature module
│   └── find_doctors/
│       └── components/  # [NEW] Feature-specific components
│           └── ReviewSpacificDoctor/ # [MOVE from core/widgets/layouts/]
├── shared/              # Feature module (unchanged)
└── main.dart            # Bootstrap (unchanged)
```

## Phased Implementation Approach

### Phase 0: Research & Data Analysis (Task Block: T001–T005)

**Objective**: Resolve unknowns and gather detailed component inventory before design.

**Tasks**:
- **T001**: Audit `lib/core/widgets/layouts/` and `lib/core/ui/` directories; document all component files, their sizes, dependencies, and usage counts across codebase.
- **T002**: Search all 50+ screens for imports of `lib/core/widgets/layouts/`; generate dependency graph showing which screens depend on which legacy components.
- **T003**: Analyze existing `lib/core/ui/` component APIs (function signatures, parameters, props); document patterns for consistent integration of legacy components.
- **T004**: Review `lib/core/design_system/` tokens (AppColors, AppSpacing, AppTypography, AppRadius) and document usage patterns; identify gaps or inconsistencies.
- **T005**: Generate research.md summarizing findings and design recommendations for consolidation strategy.

**Output**: [specs/002-ui-consolidation/research.md](specs/002-ui-consolidation/research.md)

---

### Phase 1: Design & Contracts (Task Block: T006–T015)

**Objective**: Define component data model, migration contracts, and developer quickstart before implementation.

**Design Tasks**:
- **T006**: Create data-model.md documenting: (1) consolidated component list with old→new mappings, (2) component entity structure (name, purpose, params, variants, tokens), (3) migration sequence (phase 1–5 with interdependencies).
- **T007**: Define component API contracts: standardized parameter names, prop patterns, variant naming (e.g., `ButtonVariant.primary`, `TextFieldState.error`), responsive breakpoints (320dp, 768dp, 1024dp, 1200dp+).
- **T008**: Design `lib/core/state/` structure for app state management; document relocated files and any import changes needed.
- **T009**: Create quickstart.md with: (1) onboarding for new component system, (2) migration examples (before/after code), (3) design token usage patterns, (4) responsive layout patterns.
- **T010**: Plan `lib/core/ui/ui.dart` re-export strategy; document all 20+ public components and their categories.

**Design Validation**:
- **T011**: Re-run Constitution Check post-design to verify compliance.
- **T012**: Cross-reference design with spec success criteria (SC-001 through SC-008) to ensure all measurable outcomes are achievable.
- **T013**: Identify edge cases (old component used in tests, legacy paths in docs, plugins) and document mitigation.
- **T014**: Prepare migration checklist for Phase 2 tracking.
- **T015**: Generate contracts/ directory (minimal for Dart; mainly API documentation and examples).

**Output**: [specs/002-ui-consolidation/data-model.md](specs/002-ui-consolidation/data-model.md), [specs/002-ui-consolidation/quickstart.md](specs/002-ui-consolidation/quickstart.md), [specs/002-ui-consolidation/contracts/](specs/002-ui-consolidation/contracts/)

---

### Phase 2: Implementation Planning (Task Block: T016–T025)

**Objective**: Generate detailed task breakdown and phase sequence for actual implementation.

**Planning Tasks**:
- **T016**: Break Phase 2–5 implementation into 50–100 granular tasks; each task ≤4 hours work, clearly scoped (e.g., "Consolidate app_buttons.dart into lib/core/ui/buttons/ with design tokens and responsive layout").
- **T017**: Define Phase 2 (Containers & Utilities): Migrate fixed_widgets.dart utilities to lib/core/ui/containers/ with design tokens and responsive patterns.
- **T018**: Define Phase 3 (Button Migration): Consolidate legacy app_buttons.dart into lib/core/ui/buttons/ with design tokens, variants, responsive support.
- **T019**: Define Phase 4 (Text Field Migration): Consolidate legacy text field components into lib/core/ui/text_fields/ with design tokens, error states, accessibility.
- **T020**: Define Phase 5 (State Reorganization & Cleanup): Create lib/core/state/, move AppCubit/AppState/BlocObserver, create deprecation wrappers for legacy components during transition (with @Deprecated annotations and migration guidance), move ReviewSpacificDoctor/ to feature folder.
- **T020a**: Define Phase 5b (Deprecation Strategy): Add @Deprecated annotations to old component locations with clear error messages pointing to new locations; keep wrappers for 1 sprint to allow gradual migration.
- **T021**: Define Phase 6 (Screen Import Updates): Update all 50+ screen files to import from lib/core/ui/ instead of lib/core/widgets/layouts/ (parallelizable).
- **T022**: Define Phase 7 (Documentation & Export): Regenerate lib/core/ui/ui.dart with all 20+ exports, add doc comments to components.
- **T023**: Define Phase 8 (Testing & Validation): Run flutter test (90+ tests must pass), flutter analyze (0 errors), dart format compliance, success criteria verification.
- **T024**: Define rollback/contingency tasks (e.g., if migration breaks functionality, revert and adjust strategy).
- **T025**: Generate tasks.md with full task list, sprint recommendations, and testing checkpoints.

**Output**: [specs/002-ui-consolidation/tasks.md](specs/002-ui-consolidation/tasks.md) (generated by `/speckit.tasks` command, not this plan)

---

## Next Actions

**Phase 0**: Execute `/speckit.research` (or equivalent) to generate research.md with detailed analysis.
**Phase 1**: Execute `/speckit.design` (or equivalent) to generate data-model.md, quickstart.md, contracts/.
**Phase 2**: Execute `/speckit.tasks` to generate detailed task breakdown (tasks.md).

---

## Quality Gates & Success Verification

**Before Phase 2 Implementation**:
- ✅ research.md complete and reviewed
- ✅ data-model.md and quickstart.md complete and clear
- ✅ Constitution Check re-confirmed post-design
- ✅ Migration checklists prepared
- ✅ All 90+ existing tests still passing in test environment

**During Implementation** (per task):
- ✅ Each task includes flutter analyze & dart format checkpoints
- ✅ Component tests added for migrated components
- ✅ Import search confirms zero references to old locations

**End of Implementation**:
- ✅ All 8 Success Criteria (SC-001–SC-008) verified
- ✅ All 4 Quality Metrics (QM-001–QM-004) met
- ✅ 90+ existing tests passing
- ✅ flutter analyze: 0 errors
- ✅ dart format compliance
- ✅ PR ready for mlh-code-sample branch with Conventional Commits

---

## Complexity Tracking

No Constitution Check violations identified. Plan fully aligns with all 8 core principles and guardrails.

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |
