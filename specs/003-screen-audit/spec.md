# Feature Specification: Screen Architecture & Responsiveness Audit

**Feature Branch**: `003-screen-audit`  
**Created**: 2025-12-16  
**Status**: Draft  
**Input**: "Audit all screens to ensure they follow architecture patterns and fix UI responsiveness issues across the application"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - All screens follow SOLID architecture patterns (Priority: P1)

Developer can navigate through any screen in the app and verify that it follows the established architecture: presentation layer (screens), state management (Cubit), and data layer (repository) with proper separation of concerns.

**Why this priority**: Ensures consistency and maintainability across the entire codebase; prerequisite for passing MLH review and enabling future development.

**Independent Test**: Navigate to any screen and verify: (1) UI code is in `views/` directory, (2) State management uses Cubit in `controllers/`, (3) Data fetching uses repository pattern in `data/`, (4) No business logic in widgets, (5) Uses design tokens not inline styles.

**Acceptance Scenarios**:

1. **Given** any parent screen (home, children list, progress, etc.), **When** inspecting the code, **Then** it follows the presentation → Cubit → repository pattern with sealed state classes.
2. **Given** any doctor screen (sessions, patients, profile), **When** inspecting the code, **Then** it follows the same architecture pattern with proper layer separation.
3. **Given** any shared screen (auth, onboarding, donations), **When** inspecting the code, **Then** it uses centralized routing from `AppRouter` and design tokens from `lib/core/design_system/`.

---

### User Story 2 - All screens are responsive across different screen sizes (Priority: P1)

User can view and interact with any screen on different device sizes (mobile, tablet, desktop) without UI overflow, clipping, or interaction issues.

**Why this priority**: Critical for user experience and app usability; prevents UI breakage in production across different devices.

**Independent Test**: Run app on 3 device sizes (small mobile ~320dp, standard mobile ~375dp, tablet ~768dp) and navigate through all screens verifying: (1) No overflow errors, (2) Touch targets are accessible, (3) Text is readable, (4) Images scale properly, (5) Scrolling works correctly.

**Acceptance Scenarios**:

1. **Given** a small mobile device (320dp width), **When** user navigates through all screens, **Then** UI elements fit within viewport with proper scrolling and no overflow errors.
2. **Given** a tablet device (768dp width), **When** user views any screen, **Then** layout adapts to use available space effectively without awkward stretching or excessive whitespace.
3. **Given** any screen with text input fields, **When** keyboard appears, **Then** screen resizes appropriately and input fields remain visible and accessible.

---

### User Story 3 - All screens use design system tokens consistently (Priority: P2)

Developer can inspect any screen and verify it uses centralized design tokens (colors, typography, spacing, radius) instead of inline hardcoded values.

**Why this priority**: Ensures visual consistency and makes theme changes easy; demonstrates design system adoption for MLH review.

**Independent Test**: Search codebase for inline color hex codes, `FontWeight` literals, hardcoded padding/margin values in screen files; verify all use tokens from `lib/core/design_system/tokens/`.

**Acceptance Scenarios**:

1. **Given** any screen file, **When** searching for `Color(0x`, **Then** zero results found in migrated screens (all use `AppColors.*` from tokens).
2. **Given** any screen file, **When** searching for inline `EdgeInsets.fromLTRB` or hardcoded padding values, **Then** all use `AppSpacing.*` constants.
3. **Given** any screen file, **When** searching for `TextStyle(fontSize:`, **Then** all use `AppTypography.*` styles from design system.

---

### User Story 4 - All screens support mock data mode (Priority: P2)

Developer can enable mock data mode (`MockConfig.useMockData = true`) and navigate through all screens without backend connectivity, seeing realistic data for UI development and testing.

**Why this priority**: Enables UI development and testing when backend is unavailable or during development; improves developer experience.

**Independent Test**: Set `MockConfig.useMockData = true`, run app, navigate through all major flows (login, doctor browsing, booking, children management, progress) and verify screens display mock data without errors.

**Acceptance Scenarios**:

1. **Given** mock mode enabled, **When** user logs in with any credentials, **Then** mock login succeeds and user sees home screen with mock data.
2. **Given** mock mode enabled, **When** user browses doctors, **Then** 4 mock doctors appear with realistic data (names, specializations, ratings).
3. **Given** mock mode enabled, **When** user navigates to any feature (booking, children, progress, sessions), **Then** screen displays appropriate mock data without backend calls.

---

### User Story 5 - Screens handle error states gracefully (Priority: P3)

User encounters a network error or data loading failure on any screen and sees a clear error message with retry capability, without app crashes.

**Why this priority**: Improves user experience during failures; demonstrates proper error handling for production apps.

**Independent Test**: Simulate network errors for various screens (disconnect WiFi, use mock failure responses) and verify each screen shows error UI from `lib/core/ui/states/error_view.dart` with retry button.

**Acceptance Scenarios**:

1. **Given** network disconnected, **When** user attempts to load any data-driven screen, **Then** loading state appears followed by error view with clear message and retry button.
2. **Given** server returns error, **When** user is on any screen, **Then** appropriate error message displays without app crash and state remains recoverable.
3. **Given** error state displayed, **When** user taps retry button, **Then** screen attempts to reload data and transitions back to loading state.

---

### Edge Cases

- What happens when screen is rotated during data loading?
- How does bottom navigation handle when keyboard is displayed?
- What if image URLs return 404 errors - are placeholders shown?
- How do forms handle validation errors on small screens?
- What if user navigates back during an async operation?
- How do scrollable lists handle empty states vs loading states?
- What happens to floating action buttons on very small screens?
- How do modals and dialogs adapt to different screen sizes?
- What if text translations are significantly longer than English?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: ALL screens MUST follow the established architecture pattern: presentation layer (views/), state management (controllers/ with Cubit), and data layer (data/ with repository pattern).
- **FR-002**: ALL screens MUST use sealed class hierarchies for state management with exhaustive pattern matching.
- **FR-003**: ALL screens MUST use centralized routing from `AppRouter` with named route constants from `AppRoutes`.
- **FR-004**: ALL screens MUST use design tokens from `lib/core/design_system/tokens/` instead of inline styling (no hardcoded colors, spacing, typography).
- **FR-005**: ALL screens MUST use shared UI components from `lib/core/ui/` for common elements (buttons, text fields, cards, loading/error/empty states).
- **FR-006**: ALL screens MUST be responsive with proper layout constraints to prevent overflow on screens from 320dp to 1200dp width.
- **FR-007**: ALL text input screens MUST use `SingleChildScrollView` or `ListView` to handle keyboard appearance without obscuring input fields.
- **FR-008**: ALL data-fetching screens MUST use repository pattern and handle three states: loading, success (with data or empty), and error (with retry).
- **FR-009**: ALL screens with images MUST handle loading states, errors (404, network failure), and provide fallback placeholders.
- **FR-010**: ALL screens MUST support mock data mode when `MockConfig.useMockData = true` by using mock repositories or mock data sources.
- **FR-011**: ALL bottom navigation screens MUST maintain state when switching tabs (don't recreate on each navigation).
- **FR-012**: ALL list screens MUST implement proper empty state views when no data is available (not just blank screen).
- **FR-013**: ALL form screens MUST provide clear validation feedback and disable submit buttons during processing.
- **FR-014**: ALL screens with async operations MUST prevent multiple simultaneous submissions and show loading indicators.
- **FR-015**: Navigation MUST NOT use hardcoded route strings; all routes MUST use constants from `AppRoutes`.

### Screen Inventory *(to audit)*

**Parent Screens**:
- Navigation: `parent_navigation_screen.dart`
- Home: `parent_home_screen.dart`
- Children: `children_list_screen.dart`, `add_child_screen.dart`, `add_child_profile_screen.dart`, `edit_child_screen.dart`
- Find Doctors: `doctors_list_screen.dart`, `doctor_details_screen.dart`, `doctor_reviews_screen.dart`
- Booking: `select_slot_screen.dart`, `payment_screen.dart`, `confirm_booking_screen.dart`
- Progress: `progress_screen.dart`, `session_details_screen.dart`, `doctor_review_screen.dart`
- Screening: `autism_test_screen.dart`, `autism_checker_screen.dart`, `test_result_screen.dart`, `ai_evaluation_screen.dart`, `audio_recorder_screen.dart`
- Education: `education_screen.dart`
- Chatbot: `chatbot_screen.dart`
- Account: `profile_screen.dart`, `edit_profile_screen.dart`, `change_password_screen.dart`

**Doctor Screens**:
- Navigation: `doctor_navigation_screen.dart`
- Home: `doctor_home_screen.dart`
- Sessions: `sessions_screen.dart`, `session_management_screen.dart`, `pdf_viewer_screen.dart`
- Patients: `patients_screen.dart`
- Appointments: `appointments_screen.dart`
- Clinic: `clinic_screen.dart`
- Account: `profile_screen.dart`, `edit_profile_screen.dart`

**Shared Screens**:
- Auth: `select_role_screen.dart`, `select_auth_screen.dart`, `login_screen.dart`, `parent_signup_screen.dart`, `doctor_signup_screen.dart`, `email_verification_screen.dart`, `forgot_password_screen.dart`, `password_changed_screen.dart`
- Onboarding: `onboarding_screen.dart`, `splash_screen.dart`
- Donations: `charities_screen.dart`, `charity_info_screen.dart`, `charity_medicines_screen.dart`

### Responsiveness Issues to Fix

- **RI-001**: Screens using `EdgeInsets.fromLTRB` with hardcoded values MUST use responsive padding based on screen width (e.g., `MediaQuery` or design token calculations).
- **RI-002**: Fixed-width containers MUST use flexible widths or max-width constraints with `LayoutBuilder` or `MediaQuery`.
- **RI-003**: Row widgets with multiple children MUST handle overflow with `Expanded`, `Flexible`, or `Wrap` widgets.
- **RI-004**: Bottom navigation MUST not overlap with content when keyboard is shown (use `Scaffold.resizeToAvoidBottomInset`).
- **RI-005**: Images with fixed dimensions MUST use aspect ratio or flexible constraints to scale properly.
- **RI-006**: Text widgets MUST use `maxLines` and `overflow` properties to prevent breaking layouts.
- **RI-007**: Forms MUST use `SingleChildScrollView` to remain accessible when keyboard appears.
- **RI-008**: Card/container heights MUST adapt to content or use `SizedBox.shrink()` patterns for dynamic sizing.
- **RI-009**: Horizontal lists MUST have explicit heights or be wrapped in containers with height constraints.
- **RI-010**: Dialogs and bottom sheets MUST use `DraggableScrollableSheet` or `ListView` for content that might exceed screen height.

### Architecture Violations to Fix

- **AV-001**: Screens with direct `Dio` or API calls MUST move logic to repository layer.
- **AV-002**: Screens with business logic in `build()` methods MUST move to Cubit methods.
- **AV-003**: Screens using `BlocProvider.of` pattern MUST update to use context extensions (`context.read`, `context.watch`).
- **AV-004**: State classes not using sealed hierarchies MUST refactor to sealed classes for type safety.
- **AV-005**: Screens using inline navigation strings MUST use `AppRoutes` constants.
- **AV-006**: Screens with hardcoded colors/spacing/typography MUST use design system tokens.
- **AV-007**: Duplicate UI code MUST be extracted to shared components in `lib/core/ui/`.
- **AV-008**: Screens not handling error states MUST implement proper error handling with `ErrorView`.
- **AV-009**: Screens not handling loading states MUST implement proper loading indicators with `LoadingView`.
- **AV-010**: Screens not handling empty states MUST implement proper empty views with `EmptyView`.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of identified screens follow the architecture pattern (presentation → Cubit → repository) as verified by code inspection.
- **SC-002**: Zero overflow/rendering errors when running app on devices ranging from 320dp to 1200dp width.
- **SC-003**: Zero hardcoded color values (hex codes) found in screen files after migration (all use `AppColors.*`).
- **SC-004**: Zero hardcoded spacing values found in screen files after migration (all use `AppSpacing.*`).
- **SC-005**: 100% of data-fetching screens display loading, success/empty, and error states appropriately.
- **SC-006**: All screens function correctly in mock data mode with `MockConfig.useMockData = true`.
- **SC-007**: All form screens remain accessible when keyboard appears (no input field obstruction).
- **SC-008**: All navigation uses centralized routing (zero inline route strings in screens).
- **SC-009**: Flutter analyze shows zero errors after migration (info/warnings are acceptable).
- **SC-010**: All existing tests continue to pass after refactoring (90+ tests).

### Quality Metrics

- **QM-001**: Average widget nesting depth reduced to maximum 8 levels (from current deeper nesting).
- **QM-002**: Average screen file size reduced by extracting reusable components (target: <500 lines per screen).
- **QM-003**: Code reuse increased: at least 6 shared UI components used in 3+ screens each.
- **QM-004**: Reduced duplication: zero duplicate error handling logic (all use shared error handling).

## Dependencies & Assumptions *(mandatory)*

### Dependencies

- **Architecture specification** from `001-architecture-restructure` must be complete and documented.
- **Design system tokens** at `lib/core/design_system/tokens/` must exist and be documented.
- **Shared UI components** at `lib/core/ui/` must be available for reuse.
- **Mock data system** at `lib/core/mock/` must be functional and extensible.
- **Centralized routing** in `app/router/app_router.dart` must be established.

### Assumptions

- Backend API structure remains stable during refactoring (no breaking API changes).
- Design tokens cover all necessary UI variations (colors, spacing, typography).
- Existing tests provide sufficient coverage to catch regressions during refactoring.
- Mock data covers primary user flows for development and testing.
- Team has capacity to review and test each screen after refactoring.
- Responsive breakpoints are: small (320-479dp), medium (480-767dp), large (768+dp).

## Out of Scope

- Creating new features or user flows (only refactoring existing screens)
- Redesigning UI/UX (keeping existing designs, just fixing responsiveness and architecture)
- Adding animations or transitions (unless required for responsiveness)
- Refactoring backend API or data models
- Creating new shared components beyond what's needed for current screens
- Performance optimization beyond architecture improvements
- Accessibility features (a11y) beyond proper touch target sizes
- Internationalization (i18n) or localization (l10n)
- Dark mode support (unless existing screens already support it)

## Notes

- This audit builds upon the foundation laid by `001-architecture-restructure` specification.
- Priority is given to screens with the most user traffic: login, home, doctor browsing, booking flow.
- Screens should be refactored incrementally to minimize risk and enable testing between changes.
- Each screen refactor should include: architecture fix, responsiveness fix, design token adoption, mock data support.
- Consider creating a "screen refactor checklist" to ensure consistency across all screens.
