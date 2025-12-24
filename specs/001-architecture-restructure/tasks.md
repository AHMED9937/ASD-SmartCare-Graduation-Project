---

description: "Tasks for architecture-restructure (MLH code sample refactor)"
---

# Tasks: architecture-restructure

**Input**: Design documents from `/specs/001-architecture-restructure/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/

**Tests**: Tests are requested (unit + repository/service + widget) per spec.
**Organization**: Tasks grouped by user story to enable independent implementation and testing.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: User story label (US1, US2, ...)
- Include exact file paths in descriptions.

---

## ⚠️ CRITICAL: File Handling & Verification Rules

**Before creating/modifying any code file:**
1. **Check if file exists** — if it does, **DELETE or OVERWRITE** the existing content completely
2. Do NOT append to existing files; replace the entire content
3. Ensure the new file has proper imports and no orphan references

**After completing each task:**
1. Run `flutter analyze` to verify no compilation errors
2. Run `dart format --set-exit-if-changed .` to ensure formatting
3. Fix any errors before marking task complete

**After completing each phase:**
1. Run `flutter analyze` — must pass with no errors
2. Run `flutter test` (if tests exist) — must pass
3. Do NOT proceed to next phase if compilation fails

---

## Phases

### Phase 1: Setup (Shared Infrastructure)

- [x] T001 Create docs/ folder for architecture and design system docs in docs/
- [x] T002 Add .env.example with placeholders for API base URLs and tokens in .env.example
- [x] T003 Configure .gitignore to exclude .env and build artifacts in .gitignore
- [x] T004 Ensure analysis_options.yaml enforces lints (no changes yet; review current) in analysis_options.yaml

### Phase 2: Foundational (Blocking Prerequisites)

**⚠️ Before each task: Delete existing file if present, then create fresh. After: run `flutter analyze`**

- [x] T005 Create design system tokens scaffold (overwrite if exists) in lib/core/design_system/tokens/{colors.dart,typography.dart,spacing.dart,radius.dart}
- [x] T006 Create ThemeData setup consuming tokens (overwrite if exists) in lib/core/design_system/theme.dart
- [x] T007 Wire ThemeData and AppRouter into MaterialApp (modify existing) in lib/main.dart
- [x] T008 Create centralized Navigator 1.0 route table scaffold with fallback (overwrite if exists) in lib/app/router/app_router.dart
- [x] T009 Standardize Dio factory/interceptors (overwrite if exists) in lib/core/network/dio_factory.dart
- [x] T010 Update api_constants.dart with base URLs (overwrite if exists) in lib/core/network/api_constants.dart
- [x] T011 Define manual DI/composition point (create new) in lib/core/di/service_locator.dart
- [x] T012 Add reusable UI base folder structure (create directories) in lib/core/ui/{buttons,text_fields,search,cards,app_bar,states}
- [x] T013 Verify quickstart instructions (update if needed) in specs/001-architecture-restructure/quickstart.md
- [x] T013a **CHECKPOINT**: Run `flutter analyze` and `dart format --set-exit-if-changed .` — must pass before Phase 3

### Phase 3: User Story 1 - Consistent Design System (Priority: P1)

**Goal**: Centralized tokens and shared components used across migrated screens.
**Independent Test**: Inspect 10 migrated screens; shared components/styles match ThemeData tokens; no inline styling in migrated areas.

**⚠️ Before each task: Delete existing file if present, then create fresh. After: run `flutter analyze`**

- [x] T014 [P] [US1] Implement primary/secondary buttons (overwrite if exists) in lib/core/ui/buttons/app_button.dart
- [x] T015 [P] [US1] Implement app text field with validation (overwrite if exists) in lib/core/ui/text_fields/app_text_field.dart
- [x] T016 [P] [US1] Implement search field variant (overwrite if exists) in lib/core/ui/search/app_search_field.dart
- [x] T017 [P] [US1] Implement card/container component (overwrite if exists) in lib/core/ui/cards/app_card.dart
- [x] T018 [P] [US1] Implement app header/app bar component (overwrite if exists) in lib/core/ui/app_bar/app_header.dart
- [x] T019 [P] [US1] Implement loading/error/empty state views (overwrite if exists) in lib/core/ui/states/{loading_view.dart,error_view.dart,empty_view.dart}
- [ ] T020 [US1] Migrate 10 target screens to tokens/components (catalog fixed):
	 1) lib/shared/auth/login/views/login_screen.dart
	 2) lib/shared/auth/register_or_otp (or equivalent) screen
	 3) lib/shared/home/dashboard (or landing) screen
	 4) lib/doctor/** doctor list screen
	 5) lib/doctor/** doctor detail screen
	 6) lib/parent/find_doctors/booking/views/booking_search_screen.dart
	 7) lib/parent/find_doctors/booking/views/booking_confirm_screen.dart
	 8) lib/parent/my_children/** progress/child list screen
	 9) lib/shared/donations/** or shared/medicines/** list screen
	10) lib/shared/chatbot/** or shared/education/** screen
- [x] T021 [US1] Update color/text utils to delegate to design_system tokens in lib/core/utils (if present)
- [ ] T021a **CHECKPOINT**: Run `flutter analyze` and `flutter test` — must pass before Phase 4

### Phase 4: User Story 2 - Auth/Login Flow Cleanly Layered (Priority: P1)

**Goal**: Login uses shared UI, ThemeData tokens, Cubit orchestration, repository handles API.
**Independent Test**: Widget test covers login states; unit test covers auth repository; manual login success navigates via route table.

**⚠️ Before each task: Backup then overwrite existing files. After: run `flutter analyze`**

- [x] T022 [P] [US2] Refactor login view to shared components (overwrite existing) in lib/shared/auth/login/views/login_screen.dart
- [x] T023 [P] [US2] Refactor login cubit/state (overwrite existing) in lib/shared/auth/login/controllers/login_cubit.dart
- [x] T024 [US2] Implement auth repository (create new or overwrite) in lib/shared/auth/data/auth_repository.dart
- [x] T025 [US2] Wire login navigation to centralized route names in lib/shared/auth/login/views/login_screen.dart
- [x] T026 [P] [US2] Add widget test for login states (loading/success/error) in test/shared/auth/login/login_screen_test.dart
- [x] T027 [P] [US2] Add unit test for auth repository success/error mapping in test/shared/auth/auth_repository_test.dart
- [x] T027a [US2] Handle invalid/expired auth token: trigger safe logout + re-login prompt in lib/shared/auth/services/auth_session_manager.dart and test/shared/auth/auth_session_manager_test.dart
- [x] T027b **CHECKPOINT**: Run `flutter analyze` and `flutter test` — must pass before Phase 5 ✅ (29 tests pass, no errors)

### Phase 5: User Story 3 - Booking Flow Cleanly Layered (Priority: P2)

**Goal**: Booking uses shared UI, tokens, centralized routing, with retryable error handling.
**Independent Test**: Repo/service test for booking request; widget test for booking state; manual flow find → select → confirm works.

**⚠️ Before each task: Backup then overwrite existing files. After: run `flutter analyze`**

- [x] T028 [P] [US3] Refactor booking screens (overwrite existing) in lib/parent/find_doctors/booking/views/booking_screen.dart
- [x] T029 [P] [US3] Refactor booking cubit/state (overwrite existing) in lib/parent/find_doctors/booking/controllers/booking_cubit.dart, booking_state.dart
- [x] T030 [US3] Implement booking repository (create new or overwrite) in lib/parent/find_doctors/booking/data/booking_repository.dart
- [x] T031 [US3] Wire booking navigation to centralized route names and safe fallback in lib/parent/find_doctors/booking/views/booking_screen.dart, confirm_booking_screen.dart, lib/app/router/app_router.dart
- [x] T032 [P] [US3] Add cubit test for booking state transitions (idle/loading/success/error) in test/parent/find_doctors/booking/booking_cubit_test.dart
- [x] T033 [P] [US3] Add repository/service test for booking request mapping/errors in test/parent/find_doctors/booking/booking_repository_test.dart
- [x] T033a **CHECKPOINT**: Run `flutter analyze` and `flutter test` — must pass before Phase 6 ✅ (61 tests pass, 0 errors)

### Phase 6: User Story 4 - Centralized Routing (Priority: P2)

**Goal**: Single Navigator 1.0 route table; no scattered strings; fallback route.
**Independent Test**: Unit test maps route names to builders; unknown routes return fallback.

**⚠️ Before each task: Update existing router file incrementally. After: run `flutter analyze`**

- [x] T034 [US4] Define route names and builders (update existing) in lib/app/router/app_router.dart
- [x] T035 [US4] Add fallback/404 route handling with safe UI in lib/app/router/app_router.dart
- [x] T036 [P] [US4] Add unit test for route table coverage and fallback in test/app/router/app_router_test.dart
- [x] T037 [US4] Replace inline route strings in migrated screens with route name constants across lib/** (migrated scope): select_role_screen.dart, password_changed_screen.dart, auth_session_manager.dart
- [x] T037a **CHECKPOINT**: Run `flutter analyze` and `flutter test` — must pass before Phase 7 ✅ (90 tests pass, 0 errors)

### Phase 7: User Story 5 - CI and Tests Protect the Sample (Priority: P3)

**Goal**: CI runs format/analyze/test; required tests exist and pass.
**Independent Test**: GitHub Actions workflow green on clean clone; local commands pass.

- [x] T038 [US5] Add GitHub Actions workflow for format/analyze/test in .github/workflows/ci.yml
- [x] T039 [P] [US5] Add/mocktail setup and test utilities in test/test_util/ (already configured in pubspec.yaml)
- [x] T040 [US5] Ensure minimum tests exist: ≥3 unit, ≥2 repo/service, ≥2 widget (90 tests total)
- [x] T041 [US5] Run and document CI expectations in README.md (section for MLH review)
- [x] T041a **CHECKPOINT**: Run full CI locally: `dart format --set-exit-if-changed .`, `flutter analyze`, `flutter test` — all pass ✅

### Final Phase: Polish & Cross-Cutting

- [x] T042 [P] Update docs: architecture, design system, routing in docs/{architecture.md,design_system.md}
- [ ] T043 Clean asset filenames to snake_case and update references under assets/ and lib/
- [ ] T044 Remove commented-out code and dead files in lib/**
- [x] T045 Keep main.dart minimal (bootstrap + theme + router) in lib/main.dart (already minimal)
- [ ] T046 Prepare curated `mlh-code-sample` branch with Conventional Commits storyline in git history

## Dependencies & Execution Order

- Phase 1 → Phase 2 (blocking)
- US1 depends on Phase 2
- US2 depends on Phase 2 (can run in parallel with US1 once foundation ready)
- US3 depends on Phase 2 (parallel with US1/US2 after foundation)
- US4 depends on Phase 2 and informs US2/US3 navigation wiring
- US5 depends on core code + tests being present
- Final Polish depends on prior phases

## Parallel Execution Examples

- Tokens/components can be built in parallel (T014–T019) after T005–T012.
- Login repo/test tasks (T024, T026, T027) can run in parallel with booking repo/test tasks (T030, T032, T033) once routing and dio setup are done.
- Route table unit test (T036) can run in parallel with migration of route usages (T037).

## Implementation Strategy

- MVP first: complete Phase 2 + US1 + US2 (design system + login) for a demonstrable slice.
- Incremental: add US3 (booking), then US4 (route replacements), then US5 (CI/tests hardening), then Polish.
- Keep commits small and conventional; ensure repo stays green (format/analyze/test) at each step.

---

##  Verification Commands (Run After Each Task)

```powershell
# Quick check after each file change:
flutter analyze lib/path/to/changed/file.dart

# Full verification after each phase:
dart format --set-exit-if-changed .
flutter analyze
flutter test

# If errors occur:
# 1. Fix compilation errors first
# 2. Fix formatting issues  
# 3. Fix test failures
# 4. Do NOT proceed until all pass
```
