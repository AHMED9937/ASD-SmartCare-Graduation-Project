# Import Dependency Map

**Generated**: 2025-12-16 | **Task**: T003

## Summary

**Total Legacy Imports**: 75+ occurrences
**Files Affected**: 40+ screens/controllers
**By Component**:
- `app_buttons.dart`: 40+
- `fixed_widgets.dart`: 25+
- `app_form_text_field.dart`: 8+
- `stateless_app_text_form_field.dart`: 2+

---

## Detailed Import Map

### lib/shared/auth/ (20+ imports)

| File | Imports |
|------|---------|
| `signup/views/parent_signup_form.dart` | app_form_text_field, app_buttons |
| `signup/views/doctor_signup_form.dart` | app_form_text_field |
| `signup/views/parent_signup_screen.dart` | fixed_widgets |
| `signup/views/doctor_signup_screen.dart` | app_buttons |
| `signup/views/signup_form.dart` | app_form_text_field |
| `login/views/select_auth_screen.dart` | fixed_widgets, app_buttons |
| `password_reset/views/forgot_password_screen.dart` | app_form_text_field, fixed_widgets, app_buttons |
| `password_reset/views/new_password_screen.dart` | app_form_text_field, fixed_widgets, app_buttons |
| `password_reset/views/password_changed_screen.dart` | app_buttons |
| `verification/views/email_verification_screen.dart` | app_buttons |
| `verification/views/otp_screen.dart` | fixed_widgets, app_buttons |
| `onboarding/views/onboarding_screen.dart` | fixed_widgets, app_buttons |

---

### lib/shared/donations/ (8+ imports)

| File | Imports |
|------|---------|
| `views/charities_screen.dart` | fixed_widgets, app_buttons |
| `views/charity_details_screen.dart` | fixed_widgets |
| `views/charity_info_screen.dart` | fixed_widgets |
| `views/charity_medicines_screen.dart` | fixed_widgets, app_buttons |

---

### lib/shared/medicines/ (4+ imports)

| File | Imports |
|------|---------|
| `views/medicines_screen.dart` | fixed_widgets, app_buttons |
| `views/medicine_details_screen.dart` | fixed_widgets |

---

### lib/parent/screening/ (10+ imports)

| File | Imports |
|------|---------|
| `test/views/autism_test_screen.dart` | app_buttons |
| `test/views/autism_checker_screen.dart` | app_buttons |
| `test/controllers/autism_test_cubit.dart` | app_buttons |
| `test/controllers/autism_checker_cubit.dart` | stateless_app_text_form_field, app_buttons |
| `results/views/test_result_screen.dart` | fixed_widgets, app_buttons |
| `results/views/ai_evaluation_screen.dart` | fixed_widgets |

---

### lib/parent/find_doctors/ (6+ imports)

| File | Imports |
|------|---------|
| `booking/views/booking_screen.dart` | fixed_widgets, app_buttons |
| `booking/views/confirm_booking_screen.dart` | app_buttons |
| `booking/views/payment_screen.dart` | app_buttons |

---

### lib/parent/progress/ (5+ imports)

| File | Imports |
|------|---------|
| `views/session_details_screen.dart` | fixed_widgets, app_buttons |
| `views/progress_screen.dart` | fixed_widgets |
| `views/doctor_review_screen.dart` | app_buttons |

---

### lib/parent/my_children/ (4+ imports)

| File | Imports |
|------|---------|
| `views/add_child_profile_screen.dart` | app_form_text_field |
| `views/add_child_form.dart` | app_form_text_field |
| `views/edit_child_screen.dart` | fixed_widgets, app_buttons |

---

### lib/parent/account/ (4+ imports)

| File | Imports |
|------|---------|
| `views/profile_screen.dart` | fixed_widgets |
| `views/edit_profile_screen.dart` | fixed_widgets, app_buttons |
| `views/change_password_screen.dart` | fixed_widgets |

---

### lib/core/widgets/layouts/ (Internal - 2 imports)

| File | Imports |
|------|---------|
| `fixed_widgets.dart` | app_buttons |
| `ReviewSpacificDoctor/screen/ReviewSpacificDoctor.dart` | app_buttons |

---

## Migration Priority

Based on import count and dependency spread:

1. **`app_buttons.dart`** (40+ imports) - Highest priority, widest impact
2. **`fixed_widgets.dart`** (25+ imports) - Second priority, includes AppBar builders
3. **`app_form_text_field.dart`** (8+ imports) - Third priority, auth/forms heavy
4. **`stateless_app_text_form_field.dart`** (2 imports) - Merge with above
5. **`ReviewSpacificDoctor/`** (1 import) - Isolated, move to feature folder

---

## Parallel Update Strategy

Since there are no cross-dependencies between feature modules, import updates can be parallelized:

| Task | Module | Import Count | Can Run Parallel? |
|------|--------|--------------|-------------------|
| T035 | lib/doctor/ | 0 | ✅ Skip (no imports) |
| T036 | lib/parent/ | 35+ | ✅ Yes |
| T037 | lib/shared/ | 30+ | ✅ Yes |

**Note**: lib/doctor/ has no legacy imports - T035 can be skipped.
