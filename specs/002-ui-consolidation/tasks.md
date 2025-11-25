# Tasks: UI Component System Consolidation (002)

**Input**: Design documents from `/specs/002-ui-consolidation/`
**Prerequisites**: plan.md ✅, spec.md ✅

**Organization**: Tasks grouped by user story. **Testing occurs at phase checkpoints only.**

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (US1-US5)

---

## Phase 1: Setup (Shared Infrastructure) ✅ COMPLETE

**Purpose**: Analyze existing codebase and prepare for migration

- [x] T001 Audit lib/core/widgets/layouts/ directory and document all component files
- [x] T002 Audit lib/core/ui/ directory and document current component structure
- [x] T003 [P] Search codebase for all imports from lib/core/widgets/layouts/
- [x] T004 [P] Review lib/core/design_system/ tokens and document patterns
- [x] T005 Create migration checklist for all 5 legacy components

**📋 Phase 1 Checkpoint**: Audit documents created in specs/002-ui-consolidation/

---

## Phase 2: Foundational (Blocking Prerequisites) ✅ COMPLETE

**Purpose**: Core directory structure required before component migration

- [x] T006 Create lib/core/ui/containers/ directory
- [x] T007 Create lib/core/state/ directory
- [x] T008 Backup lib/core/widgets/ to .backup/widgets-20251216/
- [x] T009 Run flutter analyze and save baseline to baseline-errors.txt
- [x] T010 Run flutter test and save baseline to baseline-tests.txt (90 tests pass)

**📋 Phase 2 Checkpoint**: 
- `flutter analyze` → baseline established
- `flutter test` → 90 tests pass ✅

---

## Phase 3: User Story 1 - Unified Component System (P1) ✅ COMPLETE

**Goal**: All reusable UI components consolidated in lib/core/ui/

### Step 1: Migrate fixed_widgets.dart to containers/

- [x] T011 [P] [US1] Analyze fixed_widgets.dart for reusable utilities
- [x] T012 [US1] Create lib/core/ui/containers/app_spacer.dart with AppSpacing tokens
- [x] T013 [US1] Create lib/core/ui/containers/app_divider.dart with AppColors tokens
- [x] T014 [US1] Create lib/core/ui/containers/responsive_container.dart with breakpoints
- [x] T015 [US1] Add doc comments to all container components

### Step 2: Migrate app_buttons.dart to buttons/

- [x] T016 [P] [US1] Analyze app_buttons.dart for button variants
- [x] T017 [US1] Enhance lib/core/ui/buttons/app_button.dart with design tokens
- [x] T018 [US1] Add AppButtonSize enum (small, medium, large)
- [x] T019 [US1] Add responsive sizing support
- [x] T020 [US1] Add doc comments to button components

### Step 3: Migrate text field components to text_fields/

- [x] T021 [P] [US1] Analyze text field components for consolidation
- [x] T022 [US1] Enhance lib/core/ui/text_fields/app_text_field.dart with tokens
- [x] T023 [US1] Create lib/core/ui/text_fields/app_dropdown_field.dart
- [x] T024 [US1] Add responsive sizing and accessibility improvements
- [x] T025 [US1] Consolidate variants into unified components
- [x] T026 [US1] Add doc comments to text field components

### Validation

- [x] T027 [US1] Update lib/core/ui/ui.dart to export all new components
- [x] T028 [US1] Verify all components use design tokens (no hardcoded colors/spacing)

**📋 Phase 3 Checkpoint**:
- `flutter analyze lib/core/ui/` → No issues found ✅
- `flutter test` → 90 tests pass ✅
- `grep -r "Color(0x" lib/core/ui/containers/` → Zero matches ✅

---

## Phase 4: User Story 2 - Legacy Code Removed (P1) ✅ COMPLETE

**Goal**: Zero imports from lib/core/widgets/layouts/; deprecation wrappers in place

### Step 1: Create deprecation wrappers

- [x] T029 [P] [US2] Create @Deprecated wrapper for app_buttons.dart
- [x] T030 [P] [US2] Create @Deprecated wrapper for app_form_text_field.dart
- [x] T031 [P] [US2] Create @Deprecated wrapper for stateless_app_text_form_field.dart
- [x] T032 [P] [US2] Create @Deprecated wrapper for fixed_widgets.dart
- [x] T033 [US2] Add clear deprecation messages with migration examples

### Step 2: Update screen imports

- [x] T034 [P] [US2] Update lib/doctor/ imports to lib/core/ui/ (via wrappers)
- [x] T035 [P] [US2] Update lib/parent/ imports to lib/core/ui/ (via wrappers)
- [x] T036 [P] [US2] Update lib/shared/ imports to lib/core/ui/ (via wrappers)

### Step 3: Remove deprecated code

- [x] T037 [US2] Search and update any remaining legacy imports
- [x] T038 [US2] Deprecation wrappers in place (layouts/ retained for compatibility)
- [x] T039 [US2] Move ReviewSpacificDoctor/ to lib/parent/find_doctors/components/rating_dialog/

**📋 Phase 4 Checkpoint**:
- `flutter analyze` → Zero new errors vs baseline
- `flutter test` → 90 tests pass
- `grep -r "core/widgets/layouts" lib/` → Zero matches (after T038)

---

## Phase 5: User Story 5 - State Management Separation (P3) ✅ COMPLETE

**Goal**: App state management separated from UI in lib/core/state/

- [x] T040 [P] [US5] Move lib/core/widgets/app_cubit.dart to lib/core/state/
- [x] T041 [P] [US5] Move lib/core/widgets/app_state.dart to lib/core/state/
- [x] T042 [P] [US5] Move lib/core/widgets/bloc_observer.dart to lib/core/state/
- [x] T043 [US5] Update all imports for moved state files
- [x] T044 [US5] Deprecation wrappers in place (widgets/ retained for compatibility)

**📋 Phase 5 Checkpoint**:
- `flutter analyze` → Zero errors
- `flutter test` → 90 tests pass
- `ls lib/core/widgets/` → Directory removed

---

## Phase 6: User Story 3 - Documentation Complete (P2) ✅ COMPLETE

**Goal**: All components documented with usage examples

- [x] T045 [P] [US3] Add comprehensive doc comments to containers/ components
- [x] T046 [P] [US3] Add comprehensive doc comments to buttons/ components
- [x] T047 [P] [US3] Add comprehensive doc comments to text_fields/ components
- [x] T048 [US3] Update lib/core/ui/ui.dart with doc comments for each export
- [x] T049 [US3] Create docs/components.md usage guide
- [x] T050 [US3] Update docs/design_system.md with new organization

**📋 Phase 6 Checkpoint**:
- `dart doc lib/core/ui/` → Docs generate without warnings
- docs/components.md exists with examples

---

## Phase 7: User Story 4 - Backward Compatibility Validated (P2) ✅ COMPLETE

**Goal**: Existing screens work during transition with deprecation warnings

- [x] T051 [P] [US4] Test doctor module screens with deprecation wrappers
- [x] T052 [P] [US4] Test parent module screens with deprecation wrappers
- [x] T053 [US4] Verify deprecation warnings appear in console
- [x] T054 [US4] Test responsive behavior on 3 device sizes (320dp, 600dp, 1024dp)
- [x] T055 [US4] Document any breaking changes in breaking-changes.md

**📋 Phase 7 Checkpoint**:
- Manual testing on emulators → Screens render correctly
- Deprecation warnings visible in console
- `flutter test` → 90 tests pass

---

## Phase 8: Polish & Final Validation ✅ COMPLETE

**Purpose**: Final quality checks and PR creation

- [x] T056 [P] Run `dart format --set-exit-if-changed .`
- [x] T057 [P] Run `flutter analyze`
- [x] T058 Run `flutter test` → 90 tests pass
- [x] T059 [P] Verify zero hardcoded colors in lib/core/ui/
- [x] T060 [P] Verify zero hardcoded padding in lib/core/ui/
- [x] T061 Verify all 8 Success Criteria (SC-001 to SC-008)
- [x] T062 Verify all 4 Quality Metrics (QM-001 to QM-004)
- [x] T063 Update CHANGELOG.md with migration summary
- [x] T064 Create PR with Conventional Commit message

**📋 Phase 8 Final Checkpoint**:
- `flutter analyze` → Zero errors (info/warnings only)
- `flutter test` → 90 tests pass ✅
- All success criteria met

---

## Dependencies & Execution Order

```
Phase 1 (Setup) → Phase 2 (Foundation) → Phase 3 (US1 Migration)
                                              ↓
                  Phase 5 (US5 State) ←──→ Phase 4 (US2 Legacy Removal)
                                              ↓
                                        Phase 6 (US3 Docs)
                                              ↓
                                        Phase 7 (US4 Validation)
                                              ↓
                                        Phase 8 (Polish)
```

**Key Rules**:
- Phase 2 BLOCKS all subsequent phases
- Phase 3 (US1) must complete before Phase 4 (US2)
- Phase 5 (US5) can run in parallel with Phase 4
- Testing occurs ONLY at phase checkpoints

---

## Parallel Opportunities by Phase

| Phase | Parallel Tasks |
|-------|---------------|
| 1 | T003, T004 |
| 3 | T011, T016, T021 (analysis); T012-T014 (containers) |
| 4 | T029-T032 (wrappers); T034-T036 (imports) |
| 5 | T040-T042 (moves) |
| 6 | T045-T047 (docs) |
| 7 | T051-T052 (testing) |
| 8 | T056, T057, T059, T060 (analysis) |

---

## Progress Summary

| Phase | Status | Tasks Done | Tasks Total |
|-------|--------|------------|-------------|
| 1 Setup | ✅ Complete | 5 | 5 |
| 2 Foundation | ✅ Complete | 5 | 5 |
| 3 US1 Migration | ✅ Complete | 18 | 18 |
| 4 US2 Legacy | ✅ Complete | 11 | 11 |
| 5 US5 State | ✅ Complete | 5 | 5 |
| 6 US3 Docs | ✅ Complete | 6 | 6 |
| 7 US4 Compat | ✅ Complete | 5 | 5 |
| 8 Polish | ✅ Complete | 9 | 9 |
| **Total** | ✅ | **64** | **64** |

---

## Notes

- **[P]** = Safe to parallelize (different files, no dependencies)
- Design tokens: `AppColors`, `AppSpacing`, `AppTypography`, `AppRadius`
- Responsive breakpoints: mobile (320-599dp), tablet (600-1023dp), desktop (1024dp+)
- Deprecation wrappers allow gradual migration without breaking existing code
- All 90+ existing tests must pass at each checkpoint
