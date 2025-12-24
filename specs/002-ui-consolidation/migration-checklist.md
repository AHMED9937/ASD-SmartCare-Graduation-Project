# Migration Checklist

**Created**: 2025-12-16 | **Task**: T005

## Status Legend

- ⬜ Not Started
- 🟡 In Progress
- ✅ Complete
- ⏭️ Skipped (with reason)

---

## Component Migration Status

| # | Legacy Component | Target Location | Status | Notes |
|---|------------------|-----------------|--------|-------|
| 1 | `fixed_widgets.dart` | `lib/core/ui/containers/` | ⬜ | Phase 3, Step 1 |
| 2 | `app_buttons.dart` | `lib/core/ui/buttons/` | ⬜ | Phase 3, Step 2 |
| 3 | `app_form_text_field.dart` | `lib/core/ui/text_fields/` | ⬜ | Phase 3, Step 3 |
| 4 | `stateless_app_text_form_field.dart` | Merge with #3 | ⬜ | Phase 3, Step 3 |
| 5 | `ReviewSpacificDoctor/` | `lib/parent/find_doctors/components/` | ⬜ | Phase 4, T042 |

---

## Directory Creation Status

| Directory | Purpose | Status | Task |
|-----------|---------|--------|------|
| `lib/core/ui/containers/` | Layout utilities | ⬜ | T006 |
| `lib/core/state/` | State management | ⬜ | T007 |
| `.backup/widgets-YYYYMMDD/` | Rollback safety | ⬜ | T008 |

---

## Import Update Status by Module

| Module | Files | Imports | Status | Task |
|--------|-------|---------|--------|------|
| `lib/doctor/` | 0 | 0 | ⏭️ Skip | T035 (no imports) |
| `lib/parent/` | 20+ | 35+ | ⬜ | T036 |
| `lib/shared/` | 15+ | 30+ | ⬜ | T037 |
| `lib/core/widgets/layouts/` | 2 | 2 | ⬜ | Internal cleanup |

---

## State Management Migration

| File | From | To | Status | Task |
|------|------|-----|--------|------|
| `app_cubit.dart` | `lib/core/widgets/` | `lib/core/state/` | ⬜ | T045 |
| `app_state.dart` | `lib/core/widgets/` | `lib/core/state/` | ⬜ | T046 |
| `bloc_observer.dart` | `lib/core/widgets/` | `lib/core/state/` | ⬜ | T047 |

---

## Deprecation Wrappers

| Wrapper | Target | Status | Task |
|---------|--------|--------|------|
| `app_buttons.dart` wrapper | `lib/core/ui/buttons/` | ⬜ | T030 |
| `app_form_text_field.dart` wrapper | `lib/core/ui/text_fields/` | ⬜ | T031 |
| `stateless_app_text_form_field.dart` wrapper | `lib/core/ui/text_fields/` | ⬜ | T032 |
| `fixed_widgets.dart` wrapper | `lib/core/ui/containers/` | ⬜ | T033 |

---

## Quality Gates

| Gate | Command | Status | When |
|------|---------|--------|------|
| Baseline format check | `dart format .` | ⬜ | T009 |
| Baseline analyze | `flutter analyze` | ⬜ | T009 |
| Baseline tests | `flutter test` | ⬜ | T010 |
| Post-migration analyze | `flutter analyze` | ⬜ | T028, T038 |
| Post-migration tests | `flutter test` | ⬜ | T039, T044 |
| Final validation | All quality gates | ⬜ | T066-T067 |

---

## Documentation Status

| Document | Status | Task |
|----------|--------|------|
| Container docs | ⬜ | T015 |
| Button docs | ⬜ | T020 |
| Text field docs | ⬜ | T026 |
| Component guide | ⬜ | T057 |
| Architecture docs | ⬜ | T058 |

---

## Phase Completion Tracking

| Phase | Purpose | Tasks | Status |
|-------|---------|-------|--------|
| Phase 1 | Setup | T001-T005 | ✅ Complete |
| Phase 2 | Foundational | T006-T010 | ⬜ Not Started |
| Phase 3 | US1 - Migration | T011-T029 | ⬜ Not Started |
| Phase 4 | US2 - Legacy Removal | T030-T044 | ⬜ Not Started |
| Phase 5 | US5 - State Separation | T045-T052 | ⬜ Not Started |
| Phase 6 | US3 - Documentation | T053-T058 | ⬜ Not Started |
| Phase 7 | US4 - Compatibility | T059-T064 | ⬜ Not Started |
| Phase 8 | Polish | T065-T073 | ⬜ Not Started |

---

## Risk Log

| Risk | Impact | Mitigation | Status |
|------|--------|------------|--------|
| Import update breaks screens | High | Deprecation wrappers + parallel module updates | Planned |
| Test failures after migration | High | Baseline tests + incremental validation | Planned |
| Missing design tokens | Medium | Audit completed, reference doc created | ✅ Mitigated |
| Rollback needed | Medium | Backup in .backup/ directory | Planned |

---

## Next Actions

1. **Phase 2**: Create directories (T006-T007)
2. **Phase 2**: Create backup (T008)
3. **Phase 2**: Establish baselines (T009-T010)
4. **THEN**: Begin component migration (Phase 3)
