# Research: architecture-restructure

## Decisions

1. **Routing**: Use centralized Navigator 1.0 route table under `lib/app/router/app_router.dart` with named routes and safe fallback; avoid `go_router`.
   - **Rationale**: Matches constraint, keeps migration low-risk, preserves existing Navigator patterns.
   - **Alternatives**: `go_router` (rejected: added dependency, learning curve, constraint forbids).

2. **Design System**: Define tokens (colors, typography, spacing, radius, elevations) in `lib/core/design_system/tokens/` and a single `ThemeData` in `lib/core/design_system/theme.dart` consumed by reusable UI.
   - **Rationale**: Eliminates inline styling, enforces consistency, supports gradual migration.
   - **Alternatives**: Keep scattered helpers (rejected: duplication), adopt third-party DS (rejected: misaligned styles).

3. **Reusable UI**: Place shared widgets in `lib/core/ui/**` only when used in 2+ features and decoupled from feature models/cubits. Initial set: primary/secondary buttons, text field, search field, card/container, app bar/header, loading/error/empty states.
   - **Rationale**: Reduces duplication, enforces boundary between shared and feature-specific UI.
   - **Alternatives**: Leave per-feature widgets (rejected: continued duplication), move everything to core (rejected: coupling risk).

4. **State & DI**: Keep Cubit as primary state management; manual DI wiring in a single composition point (likely `main.dart`/`app_bootstrap.dart`), no new DI frameworks.
   - **Rationale**: Matches current stack, low complexity, testable via factory wiring.
   - **Alternatives**: `injectable`/codegen (rejected: added complexity), service locators everywhere (rejected: hidden deps).

5. **API Layer**: Standardize Dio setup: base URL from `core/network/api_constants.dart`, auth header interceptor using cached token, dev-only logging, consistent error mapping; avoid heavy retry/backoff unless simple retry is low-risk.
   - **Rationale**: Consistency and debuggability without over-engineering.
   - **Alternatives**: Per-feature Dio instances (rejected: duplication), global retry/backoff (rejected: hidden failures/complexity).

6. **Testing & CI**: Use `flutter test` with mocktail; add unit, repository/service, and widget tests for shared component + login + booking. GitHub Actions runs format/analyze/test.
   - **Rationale**: Meets acceptance criteria and MLH expectations.
   - **Alternatives**: Skip CI or goldens-only (rejected: fails acceptance/coverage goals).

7. **Platforms**: Android/iOS only; Web out of scope.
   - **Rationale**: Constraint from requirements.
   - **Alternatives**: Add Web (rejected: scope and effort).

## Clarifications Resolved
- No outstanding NEEDS CLARIFICATION items.

## Scope Notes
- Target 10 screens for token/component migration (to be enumerated during implementation).
- Shared components must be parameterized and theme-driven; feature-only widgets stay in feature folders.
