# ASD SmartCare Constitution
<!-- Applies to MLH-ready refactor for this Flutter repository -->

<!-- Sync Impact Report
Version change: none -> 1.0.0
Modified principles: (new) Plan-First Delivery; Structural Guardrails; SOLID Layering; Design System & UI Reuse; Routing & Platforms Hygiene
Added sections: Quality & Security Constraints; Workflow & Reviews
Removed sections: none
Templates requiring updates: ✅ .specify/templates/plan-template.md | ⚠ pending: .specify/templates/spec-template.md, .specify/templates/tasks-template.md (no blocking conflicts but ensure future outputs respect principles)
Follow-up TODOs: none
-->

## Core Principles

### I. Plan-First Delivery
No refactor starts without a written plan derived from the feature spec; always follow Audit → Plan → Implement.

### II. Structural Guardrails
Preserve `lib/` layout (core/, doctor/, parent/, shared/, main.dart). Allowed additions only: `lib/app/` for bootstrap+routing, `lib/core/design_system/` for tokens+ThemeData, `lib/core/ui/` for reusable UI. No other top-level churn.

### III. SOLID Layering
Enforce dependency direction UI → Cubit/Controller → Usecase/Service → Repository → Datasource. UI/cubits never perform networking/parsing/mapping; DI stays manual and explicit in one place.

### IV. Design System & UI Reuse
Centralize tokens (colors/typography/spacing/radius) in `lib/core/design_system/` and consume them via ThemeData. Shared components live only in `lib/core/ui/**`, are parameterized, and used across features to eliminate duplication and inline styling.

### V. Routing & Platform Hygiene
Use a single Navigator 1.0 route table (no go_router); route names defined in one place under `lib/app/router/` (or equivalent) with safe fallback. Platforms in scope: Android + iOS only (Web out of scope). Enforce naming hygiene (snake_case, no spaces), remove commented-out code, keep main.dart minimal bootstrap.

## Quality & Security Constraints

- Quality gates: `dart format --set-exit-if-changed .`, `flutter analyze`, and `flutter test` must pass.
- Secrets/configs never committed; use `.env.example`, `.gitignore`, and/or `--dart-define`.
- API: base URLs in `lib/core/network/api_constants.dart`; auth header injection via shared client; dev-only logging; consistent error mapping; avoid heavy retry/backoff unless justified.
- Assets: filenames snake_case; update references when renamed.
- Design migrations: reduce inline styling; migrate screens to tokens/components progressively.

## Workflow & Reviews

- Branching: curated MLH story on `mlh-code-sample` with Conventional Commits (feat/refactor/docs/test/ci/chore); keep repo working between commits.
- Routing and design-system migrations must be reviewed for adherence to Principles II–V before merge.
- Reusable UI moves to `lib/core/ui/` only after proving 2+ feature usages and zero feature-specific coupling.
- Plans precede implementation; tasks and plans must cite constitution gates in the Constitution Check.

## Governance

- This constitution is the single source of delivery rules; all specs, plans, tasks, PRs, and CI checks must comply.
- Amendments require noting version bump, rationale, and updating affected templates and guidance; Material changes reviewed by maintainers.
- Compliance is verified at plan, task generation, and PR review; violations must be justified in "Complexity Tracking" with safer alternatives documented.

**Version**: 1.0.0 | **Ratified**: 2025-12-16 | **Last Amended**: 2025-12-16
