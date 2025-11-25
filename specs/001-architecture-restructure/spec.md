# Feature Specification: Architecture Restructure (MLH Code Sample)

**Feature Branch**: `001-architecture-restructure`  
**Created**: 2025-12-16  
**Status**: Draft  
**Input**: Architecture restructure to deliver MLH-grade sample: SOLID refactors, reusable UI, centralized Navigator 1.0 routing, design system tokens, showcase Login + Booking flows, tests + CI, curated `mlh-code-sample` branch.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Reviewer sees consistent design system (Priority: P1)

MLH reviewer can open the app and see consistent colors/typography/spacing across screens using shared tokens and reusable UI components.

**Why this priority**: First impression and readability for MLH review; enables reuse across all features.

**Independent Test**: Run app; inspect 10 migrated screens to confirm they use shared tokens/components (no inline styling in migrated areas).

**Acceptance Scenarios**:

1. **Given** the app runs on Android/iOS, **When** navigating through migrated screens, **Then** text/button/card styles match centralized ThemeData tokens.
2. **Given** a shared UI component (e.g., primary button), **When** used in multiple screens, **Then** its style is identical without screen-level overrides.

---

### User Story 2 - Auth/Login flow is cleanly layered (Priority: P1)

User can complete the login flow with clear separation of presentation, state (Cubit), and data, backed by shared UI and tokens.

**Why this priority**: Demonstrates SOLID layering on a critical flow; high reviewer impact.

**Independent Test**: Widget test covers login UI states; unit test covers auth repository; manual run confirms navigation on success.

**Acceptance Scenarios**:

1. **Given** valid credentials, **When** user submits the login form, **Then** the Cubit emits loading → success and navigates via centralized route table to the post-login screen.
2. **Given** invalid credentials, **When** user submits, **Then** the Cubit emits error and the UI shows a consistent error component with no navigation.

---

### User Story 3 - Booking flow is cleanly layered (Priority: P2)

Parent user can search/select a doctor and confirm booking using shared components and centralized routing.

**Why this priority**: Second showcase flow proving reuse and SOLID across a multi-step journey.

**Independent Test**: Repository/service test for booking request; widget test for booking screen state changes; manual path through find → select → confirm uses shared UI.

**Acceptance Scenarios**:

1. **Given** available doctors, **When** user selects one and submits booking, **Then** booking request is sent and success state is shown with consistent success UI.
2. **Given** network failure, **When** user submits, **Then** error state surfaces via shared error component and can retry without app crash.

---

### User Story 4 - Routing is centralized (Priority: P2)

Navigation uses a single Navigator 1.0 route table; screens register routes in one place, eliminating scattered strings.

**Why this priority**: Reduces navigation drift and reviewer confusion; prerequisite for maintainability.

**Independent Test**: Unit test for route table maps known route names to builders; runtime navigation succeeds for migrated routes without inline strings.

**Acceptance Scenarios**:

1. **Given** a known route name, **When** `Navigator.pushNamed` is called, **Then** the route is resolved from the centralized table and builds the correct screen.
2. **Given** an unknown route name, **When** navigation is attempted, **Then** a fallback/404 route is returned without crashing the app.

---

### User Story 5 - CI and tests protect the sample (Priority: P3)

CI runs format/analyze/test on push/PR; required tests exist for shared components and showcase flows.

**Why this priority**: Ensures reviewers can verify quality quickly; prevents regressions.

**Independent Test**: GitHub Actions workflow passes on clean clone; `flutter test`, `flutter analyze`, and `dart format --set-exit-changed .` succeed locally.

**Acceptance Scenarios**:

1. **Given** a clean clone, **When** CI runs, **Then** all steps (format check, analyze, tests) pass without manual intervention.
2. **Given** the shared component and flow tests, **When** code changes, **Then** failures point to the affected layer (UI/state/repo) clearly.

### Edge Cases

- Missing/invalid auth token in cache should trigger safe logout and re-login prompt without crash.
- Unknown route name should return a safe fallback screen and log a warning.
- Network failure in booking should show retryable error UI without losing selected doctor/context.
- Theme token missing: component falls back to default token set without inline overrides.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Provide centralized Navigator 1.0 route table with named routes and onGenerateRoute, covering migrated flows and a safe fallback.
- **FR-002**: Establish design tokens (colors, typography, spacing, radius, elevations) under `lib/core/design_system/` and expose a single ThemeData.
- **FR-003**: Create at least 6 reusable UI components under `lib/core/ui/**` (e.g., primary/secondary buttons, text field, search field, card/container, app bar/header, status banners for loading/error/empty) and use each in 2+ places.
- **FR-004**: Migrate at least 10 screens away from inline styling to use ThemeData tokens and reusable components.
- **FR-005**: Refactor Login/Auth flow (`shared/auth/login`) to SOLID layers (presentation, Cubit, repository/service) with shared UI and centralized routing.
- **FR-006**: Refactor Booking flow (`parent/find_doctors/booking`) to SOLID layers with shared UI and centralized routing; ensure error/retry handling.
- **FR-007**: Standardize API layer: base URLs from `core/network/api_constants.dart`; auth header injection; dev-only logging; consistent error mapping; avoid new heavy retry/backoff.
- **FR-008**: Define manual DI wiring in one place (no new DI framework) for shared services (Dio, cache, repositories) to support tests.
- **FR-009**: Add tests: minimum 3 unit tests, 2 repository/service tests, 2 widget tests (one shared component, one key screen state) using mocktail.
- **FR-010**: Add GitHub Actions workflow to run format check, analyze, and tests on push/PR.
- **FR-011**: Clean asset filenames to snake_case and update references.
- **FR-012**: Produce `mlh-code-sample` branch with curated Conventional Commits storyline (branch-level requirement).

### Key Entities *(include if feature involves data)*

- **DesignTokenSet**: colors, typography scales, spacing, radii, elevations; consumed by ThemeData and shared components.
- **AppRoute**: name, path params, builder, and optional guards; lives in centralized route table.
- **AuthSession**: access token, refresh token (if present), expiry; persisted via cache helper; injected into Dio headers.
- **BookingRequest**: doctor id, user/patient id, slot/time, notes; sent via booking repository; maps errors to UI-friendly states.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: `dart format --set-exit-changed .`, `flutter analyze`, and `flutter test` all pass on a clean clone (CI and local).
- **SC-002**: At least 6 shared UI components in `lib/core/ui/**` are referenced in 2+ distinct screens each.
- **SC-003**: At least 10 screens are updated to use centralized ThemeData tokens with no inline style overrides for primary UI elements.
- **SC-004**: Central route table exists; migrated screens use named routes only; navigating with an unknown route returns a safe fallback.
- **SC-005**: Tests added: ≥3 unit, ≥2 repository/service, ≥2 widget (one shared component, one key screen state) using mocktail.
- **SC-006**: GitHub Actions workflow runs on push/PR and completes format check, analyze, and tests without manual steps.
- **SC-007**: `mlh-code-sample` branch exists with a clean, Conventional Commit narrative suitable for reviewer walkthrough.

## Assumptions

- Platforms: Android and iOS only; Web is out of scope.
- State management remains Cubit/Bloc; no new DI framework (manual wiring only).
- Secrets are not committed; configs use `.env.example` and/or `--dart-define`.
- No new product features; work is refactor and quality focused.

## Open Questions

- None at this time; prior clarifications resolved scope and constraints.
