# Audit: Legacy Components in lib/core/widgets/layouts/

**Audited**: 2025-12-16 | **Task**: T001

## Summary

| Component | Lines | Import Count | Status |
|-----------|-------|--------------|--------|
| `app_buttons.dart` | ~55 | 40+ | Migrate to `lib/core/ui/buttons/` |
| `app_form_text_field.dart` | 151 | 8+ | Migrate to `lib/core/ui/text_fields/` |
| `stateless_app_text_form_field.dart` | 118 | 2+ | Merge with above |
| `fixed_widgets.dart` | ~90 | 25+ | Migrate to `lib/core/ui/containers/` |
| `ReviewSpacificDoctor/` | ~dir | 1 | Move to `lib/parent/find_doctors/components/` |

**Total Legacy Imports in Screens**: 75+ occurrences across 40+ files

---

## Component Details

### 1. app_buttons.dart (55 lines)

**Purpose**: Button utility class with static methods

**Components**:
- `AppButtons.containerTextButton()` - Primary filled button with customizable container
- `AppButtons.simpleTxtButton()` - Plain text button wrapper
- `AppButtons.arrowbutton()` - Back navigation icon button

**Issues Found**:
- ❌ Hardcoded colors: `Color(0xFF133E87)` (should use `AppColors.primary`)
- ❌ Hardcoded radius: `BorderRadius.all(Radius.circular(11))` (should use `AppRadius.*`)
- ❌ Hardcoded padding: `EdgeInsets.symmetric(horizontal: 33, vertical: 6)`
- ❌ Static methods instead of widget class (inconsistent with lib/core/ui/ patterns)
- ❌ No doc comments
- ❌ No size variants (small/medium/large)
- ❌ No state support (hover/pressed/disabled)

**Migration Target**: Enhance existing `lib/core/ui/buttons/app_button.dart`

---

### 2. app_form_text_field.dart (151 lines)

**Purpose**: Stateful text field widget with dropdown and file picker support

**Components**:
- `Appformtextfield` - Main stateful widget

**Features**:
- Dropdown mode with `DropdownButtonFormField`
- File picker mode with async callback
- Customizable borders, hints, validation

**Issues Found**:
- ❌ Hardcoded colors: `Color(0xFFB5B1B1)`, `Color.fromRGBO(62, 135, 107, 0.42)`
- ❌ Hardcoded radius: `BorderRadius.circular(20)` (should use `AppRadius.*`)
- ❌ Hardcoded padding: `EdgeInsets.symmetric(vertical: 16.5, horizontal: 7)`
- ❌ Inconsistent naming: `Appformtextfield` (should be `AppFormTextField`)
- ❌ Inconsistent parameter naming: `TextController`, `MyonTapFunc` (not camelCase)
- ❌ No error/success states
- ❌ No doc comments

**Migration Target**: Enhance `lib/core/ui/text_fields/app_text_field.dart`

---

### 3. stateless_app_text_form_field.dart (118 lines)

**Purpose**: Stateless version of text field (similar to above)

**Components**:
- `StlsAppTextFormField` - Stateless text field widget

**Features**:
- Nearly identical to `Appformtextfield` but stateless
- Same dropdown and file picker support

**Issues Found**:
- ❌ Duplicate functionality (should be one component)
- ❌ Same hardcoded styling issues
- ❌ Inconsistent naming: `StlsAppTextFormField` (abbreviation unclear)

**Migration Strategy**: Merge into single `AppTextField` with optional state management

---

### 4. fixed_widgets.dart (~90 lines)

**Purpose**: AppBar builders and navigation helpers

**Components**:
- `AppBarWithLogo()` - AppBar with logo image
- `defaultAppBar()` - Plain white AppBar
- `NavgatTO()` - Navigation push helper (typo in name)
- `AppBarWithText()` - AppBar with title text
- `asdR()` - Autism level indicator widget

**Issues Found**:
- ❌ Hardcoded colors: `Colors.white`, `Color(0xFF082F71)`, `Color(0xFF000FAF)`, `Color(0xFF000649)`
- ❌ Hardcoded sizes: `toolbarHeight: 80`, `width: 66`, `height: 66`
- ❌ Function naming: `NavgatTO`, `asdR` (typos, not descriptive)
- ❌ Mixed responsibilities (AppBars + navigation + UI widgets)
- ❌ No doc comments
- ❌ Imports legacy `app_buttons.dart`

**Migration Strategy**: 
- AppBar builders → Keep in feature-specific code or move to `lib/core/ui/app_bar/`
- `asdR()` → Move to `lib/parent/screening/` as feature-specific
- Layout helpers → Create `lib/core/ui/containers/` utilities

---

### 5. ReviewSpacificDoctor/ (Directory)

**Purpose**: Feature-specific component for doctor reviews

**Files**:
- `screen/ReviewSpacificDoctor.dart`

**Issues Found**:
- ❌ Feature-specific component in core directory
- ❌ Directory name has typo ("Spacific" → "Specific")
- ❌ Imports legacy `app_buttons.dart`

**Migration Target**: Move to `lib/parent/find_doctors/components/ReviewSpecificDoctor/`

---

## Import Locations Summary

### By Feature Module

| Module | Import Count | Files Affected |
|--------|--------------|----------------|
| `lib/shared/auth/` | 20+ | signup, login, password_reset, verification, onboarding |
| `lib/shared/donations/` | 8+ | charities, charity_details, charity_medicines |
| `lib/shared/medicines/` | 4+ | medicines_screen, medicine_details |
| `lib/parent/screening/` | 10+ | autism_test, autism_checker, test_result |
| `lib/parent/find_doctors/` | 6+ | booking, confirm_booking, payment |
| `lib/parent/progress/` | 5+ | session_details, progress_screen, doctor_review |
| `lib/parent/my_children/` | 4+ | add_child, edit_child |
| `lib/parent/account/` | 4+ | profile, edit_profile, change_password |
| `lib/doctor/` | 0 | (no legacy imports found) |

### By Legacy Component

| Component | Import Count |
|-----------|--------------|
| `app_buttons.dart` | 40+ |
| `fixed_widgets.dart` | 25+ |
| `app_form_text_field.dart` | 8+ |
| `stateless_app_text_form_field.dart` | 2+ |
| `ReviewSpacificDoctor` | 1 |

---

## Recommendations

1. **Order of Migration**:
   - Phase 3.1: `fixed_widgets.dart` → containers/ (foundational utilities)
   - Phase 3.2: `app_buttons.dart` → buttons/ (most imports - high impact)
   - Phase 3.3: text fields → text_fields/ (consolidate both files)
   - Phase 3.4: `ReviewSpacificDoctor/` → feature folder (isolated)

2. **Import Update Strategy**:
   - Create deprecation wrappers first (Phase 4.1)
   - Update imports by module (parallelizable: doctor/, parent/, shared/)
   - Run flutter analyze after each module update
   - Delete deprecated directory last

3. **Testing Checkpoints**:
   - After each component migration: flutter analyze + flutter test
   - After import updates per module: module-specific tests
   - Final validation: full test suite (90+ tests)
