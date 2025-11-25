# Audit: Current UI Components in lib/core/ui/

**Audited**: 2025-12-16 | **Task**: T002

## Summary

| Directory | Components | Status | Design Tokens |
|-----------|------------|--------|---------------|
| `app_bar/` | 1 | ✅ Good | ✅ Yes |
| `buttons/` | 1 (app_button.dart) | ✅ Good | ✅ Yes |
| `cards/` | 1 | ✅ Good | ✅ Yes |
| `search/` | 1 | ✅ Good | ✅ Yes |
| `states/` | 3 (loading, error, empty) | ✅ Good | ✅ Yes |
| `text_fields/` | 1 (app_text_field.dart) | ✅ Good | ✅ Yes |
| `ui.dart` | Export barrel | ✅ Good | N/A |

**Total Current Components**: 8+ components, well-organized

---

## Directory Structure

```
lib/core/ui/
├── app_bar/
│   └── app_header.dart
├── buttons/
│   └── app_button.dart        # ← Target for legacy app_buttons.dart migration
├── cards/
│   └── app_card.dart
├── search/
│   └── app_search_field.dart
├── states/
│   ├── loading_view.dart
│   ├── error_view.dart
│   └── empty_view.dart
├── text_fields/
│   └── app_text_field.dart    # ← Target for legacy text field migration
├── ui.dart                     # Central export barrel
└── containers/                 # [TO CREATE] Target for fixed_widgets.dart
```

---

## Component Details

### 1. buttons/app_button.dart (151 lines)

**Purpose**: Primary button component with variants

**Features**:
- ✅ Uses design tokens (`AppColors.*`, via `tokens.dart`)
- ✅ Supports 3 styles: `primary`, `secondary`, `text`
- ✅ Named constructors: `AppButton.primary()`, `AppButton.secondary()`, `AppButton.text()`
- ✅ Loading state support
- ✅ Optional icon support
- ✅ Expanded width option
- ✅ Doc comments with usage examples

**API**:
```dart
AppButton({
  required String label,
  VoidCallback? onPressed,
  AppButtonStyle style,
  bool isLoading,
  IconData? icon,
  bool expanded,
})
```

**What Legacy Migration Needs to Add**:
- Size variants (small, medium, large)
- Hover/pressed/disabled state visuals
- Responsive sizing via breakpoints
- Arrow button variant (from legacy `arrowbutton`)

---

### 2. text_fields/app_text_field.dart

**Features**:
- Uses design tokens
- Standard text input support

**What Legacy Migration Needs to Add**:
- Dropdown mode (from `app_form_text_field.dart`)
- File picker mode (from `app_form_text_field.dart`)
- Error/success states with visual feedback
- Responsive sizing

---

### 3. ui.dart (Central Export)

**Current Exports**:
```dart
// Buttons
export 'buttons/app_button.dart';

// Text Fields
export 'text_fields/app_text_field.dart';

// Search
export 'search/app_search_field.dart';

// Cards
export 'cards/app_card.dart';

// App Bar
export 'app_bar/app_header.dart';

// State Views
export 'states/loading_view.dart';
export 'states/error_view.dart';
export 'states/empty_view.dart';
```

**Total Exports**: 8 components

**After Migration (Expected)**:
- Add: `containers/app_spacer.dart`
- Add: `containers/app_divider.dart`
- Add: `containers/responsive_container.dart`
- Enhanced: `buttons/app_button.dart` (new variants)
- Enhanced: `text_fields/app_text_field.dart` (dropdown, file picker)

---

## Design Token Usage Verification

### AppColors (from lib/core/design_system/tokens/colors.dart)

| Token | Used In |
|-------|---------|
| `AppColors.primary` | app_button.dart ✅ |
| `AppColors.secondary` | app_button.dart ✅ |
| `AppColors.onPrimary` | app_button.dart ✅ |
| `AppColors.error` | states/error_view.dart ✅ |
| `AppColors.surface` | cards/app_card.dart ✅ |

### AppSpacing (from lib/core/design_system/tokens/spacing.dart)

| Token | Available |
|-------|-----------|
| `AppSpacing.xs` | 4dp ✅ |
| `AppSpacing.sm` | 8dp ✅ |
| `AppSpacing.md` | 16dp ✅ |
| `AppSpacing.lg` | 24dp ✅ |
| `AppSpacing.xl` | 32dp ✅ |

### AppRadius (from lib/core/design_system/tokens/radius.dart)

| Token | Available |
|-------|-----------|
| `AppRadius.sm` | 8dp ✅ |
| `AppRadius.md` | 12dp ✅ |
| `AppRadius.lg` | 16dp ✅ |
| `AppRadius.full` | 9999dp (pill) ✅ |

### AppTypography (from lib/core/design_system/tokens/typography.dart)

| Token | Available |
|-------|-----------|
| `AppTypography.headlineLarge` | 32px bold ✅ |
| `AppTypography.bodyMedium` | 14px regular ✅ |
| `AppTypography.labelLarge` | 14px medium ✅ |

---

## Migration Integration Points

### Existing Patterns to Follow

1. **Widget Class Structure**:
   ```dart
   class AppButton extends StatelessWidget {
     final String label;
     final VoidCallback? onPressed;
     // ... named parameters
     
     const AppButton({super.key, required this.label, ...});
     
     // Named constructors for variants
     const AppButton.primary(...);
     const AppButton.secondary(...);
   }
   ```

2. **Design Token Import**:
   ```dart
   import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
   ```

3. **Doc Comment Style**:
   ```dart
   /// Brief description.
   ///
   /// Usage:
   /// ```dart
   /// AppButton(label: 'Submit', onPressed: () {})
   /// ```
   class AppButton extends StatelessWidget { ... }
   ```

---

## Gaps to Fill (New Directory)

### lib/core/ui/containers/ (To Create)

**Purpose**: Layout utilities from `fixed_widgets.dart`

**Components to Create**:
1. `app_spacer.dart` - Vertical/horizontal spacing widget
2. `app_divider.dart` - Styled divider with design tokens
3. `responsive_container.dart` - Breakpoint-aware container

**Pattern to Follow**:
```dart
import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// Responsive container with breakpoint support.
///
/// Usage:
/// ```dart
/// ResponsiveContainer(
///   mobile: MobileLayout(),
///   tablet: TabletLayout(),
/// )
/// ```
class ResponsiveContainer extends StatelessWidget {
  // ...
}
```

---

## Checklist for Migration

- [ ] Create `lib/core/ui/containers/` directory
- [ ] Add `app_spacer.dart` with `AppSpacing.*` tokens
- [ ] Add `app_divider.dart` with `AppColors.divider`
- [ ] Add `responsive_container.dart` with breakpoints
- [ ] Enhance `app_button.dart` with size variants
- [ ] Enhance `app_text_field.dart` with dropdown/file picker
- [ ] Update `ui.dart` exports
- [ ] Verify all components use design tokens
- [ ] Add doc comments to all new/enhanced components
