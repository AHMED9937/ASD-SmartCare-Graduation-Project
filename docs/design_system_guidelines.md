# Design System Guidelines

## Overview

All UI components and screens in ASD SmartCare **must** use the centralized design system tokens defined in `lib/core/design_system/`. This ensures visual consistency, easier theme changes, and maintainability.

## Quick Start

```dart
// Import everything you need in one line
import 'package:asdsmartcare/core/ui/ui.dart';
```

This barrel export gives you access to:
- `AppColors` - Color tokens
- `AppTypography` - Text styles
- `AppSpacing` - Spacing/sizing values
- `AppRadius` - Border radius values
- `AppShadows` - Box shadow presets
- All core UI components (AppButton, AppCard, AppHeader, etc.)

---

## ✅ DO

### Colors
```dart
// ✅ Use AppColors for all colors
Container(color: AppColors.primary)
Container(color: AppColors.background)
Container(color: AppColors.surface)

// ✅ Use semantic colors for feedback
Icon(Icons.check, color: AppColors.success)
Icon(Icons.error, color: AppColors.error)
Text('Warning', style: TextStyle(color: AppColors.warning))
```

### Typography
```dart
// ✅ Use AppTypography for text styles
Text('Headline', style: AppTypography.headlineLarge)
Text('Body text', style: AppTypography.bodyMedium)
Text('Label', style: AppTypography.labelSmall)

// ✅ Use copyWith for color/weight overrides
Text(
  'Custom',
  style: AppTypography.titleLarge.copyWith(
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
  ),
)
```

### Spacing
```dart
// ✅ Use AppSpacing for all padding/margin
Padding(padding: EdgeInsets.all(AppSpacing.md))
SizedBox(height: AppSpacing.lg)
Container(margin: EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH))

// ✅ Use semantic spacing
EdgeInsets.all(AppSpacing.cardPadding)
EdgeInsets.symmetric(vertical: AppSpacing.listItemSpacing)
```

### Border Radius
```dart
// ✅ Use AppRadius for all border radius
Container(
  decoration: BoxDecoration(
    borderRadius: AppRadius.card, // Semantic
  ),
)

Container(
  decoration: BoxDecoration(
    borderRadius: AppRadius.mdRadius, // Generic scale
  ),
)

// ✅ Use for RoundedRectangleBorder
RoundedRectangleBorder(borderRadius: AppRadius.button)
```

### Shadows
```dart
// ✅ Use AppShadows for all box shadows
Container(
  decoration: BoxDecoration(
    boxShadow: AppShadows.card, // Returns List<BoxShadow>
  ),
)

// ✅ Use semantic shadows
BoxDecoration(boxShadow: AppShadows.cardElevated)
BoxDecoration(boxShadow: AppShadows.dialog)
```

### Components
```dart
// ✅ Use core UI components before creating custom ones
AppButton(label: 'Submit', onPressed: _onSubmit)
AppCard(child: content)
AppHeader(title: 'Screen Title')
AppTextField(controller: _controller, label: 'Email')
```

---

## ❌ DON'T

### Colors
```dart
// ❌ Never use hex colors directly
Container(color: Color(0xFF133E87)) // Bad!
Container(color: Colors.blue) // Bad!
Container(color: Colors.grey.shade600) // Bad!

// ❌ Never use Colors.black/white without purpose
Text('', style: TextStyle(color: Colors.black)) // Bad!
// Use AppColors.onSurface or AppColors.onPrimary instead
```

### Typography
```dart
// ❌ Never use fontSize directly
TextStyle(fontSize: 16) // Bad!
TextStyle(fontSize: 24, fontWeight: FontWeight.bold) // Bad!

// ❌ Never create TextStyle from scratch when AppTypography exists
const TextStyle(
  fontFamily: 'Roboto',
  fontSize: 18,
  fontWeight: FontWeight.w500,
) // Bad! Use AppTypography.titleLarge
```

### Spacing
```dart
// ❌ Never use magic numbers for spacing
EdgeInsets.all(16) // Bad!
SizedBox(height: 24) // Bad!
Padding(padding: EdgeInsets.symmetric(horizontal: 20)) // Bad!

// ❌ Never use EdgeInsets.fromLTRB with hardcoded values
EdgeInsets.fromLTRB(24, 48, 24, 16) // Bad!
// Use AppSpacing tokens: EdgeInsets.fromLTRB(AppSpacing.xl, AppSpacing.xxxl, AppSpacing.xl, AppSpacing.md)
```

### Border Radius
```dart
// ❌ Never use BorderRadius.circular with magic numbers
BorderRadius.circular(8) // Bad!
BorderRadius.circular(16) // Bad!
BorderRadius.circular(23) // Bad!

// ❌ Never use Radius.circular directly with numbers
Radius.circular(12) // Bad! Use AppRadius values
```

### Shadows
```dart
// ❌ Never create BoxShadow inline
BoxShadow(
  color: Colors.black.withOpacity(0.1),
  blurRadius: 10,
  offset: Offset(0, 4),
) // Bad! Use AppShadows.md or similar
```

---

## Migration Checklist

When migrating an existing screen:

1. [ ] Import `package:asdsmartcare/core/ui/ui.dart`
2. [ ] Replace all `Color(0xFFxxxxxx)` with `AppColors.xxx`
3. [ ] Replace all `Colors.xxx` with `AppColors.xxx`
4. [ ] Replace all `TextStyle(fontSize: xx)` with `AppTypography.xxx`
5. [ ] Replace all `EdgeInsets.all(xx)` with `EdgeInsets.all(AppSpacing.xxx)`
6. [ ] Replace all `BorderRadius.circular(xx)` with `AppRadius.xxxRadius`
7. [ ] Replace all inline `BoxShadow(...)` with `AppShadows.xxx`
8. [ ] Remove unused imports (e.g., `text_utils.dart`)
9. [ ] Run `flutter analyze` to verify no errors
10. [ ] Test the screen visually

---

## Token Reference

### Spacing Scale
| Token | Value | Use Case |
|-------|-------|----------|
| `xxs` | 2dp | Micro gaps |
| `xs` | 4dp | Tight spacing |
| `sm` | 8dp | List items, icon gaps |
| `md` | 12dp | Default padding |
| `lg` | 18dp | Section gaps |
| `xl` | 24dp | Large gaps |
| `xxl` | 36dp | Section dividers |
| `xxxl` | 48dp | Page sections |

### Typography Scale
| Token | Size | Use Case |
|-------|------|----------|
| `headlineLarge` | 28 | Page titles |
| `headlineMedium` | 24 | Section titles |
| `headlineSmall` | 20 | Sub-section titles |
| `titleLarge` | 18 | Card titles |
| `titleMedium` | 14 | List item titles |
| `bodyLarge` | 16 | Primary body text |
| `bodyMedium` | 14 | Default body text |
| `bodySmall` | 12 | Secondary text |
| `labelLarge` | 14 | Button labels |
| `labelSmall` | 11 | Captions, hints |

### Radius Scale
| Token | Value | Use Case |
|-------|-------|----------|
| `xs` | 4dp | Small chips |
| `sm` | 8dp | Buttons, inputs |
| `md` | 12dp | Cards (default) |
| `lg` | 16dp | Dialogs |
| `xl` | 24dp | Bottom sheets |
| `full` | 9999dp | Pills, avatars |

---

## Questions?

If you need a new token (color, spacing, etc.), add it to the appropriate file in `lib/core/design_system/tokens/` rather than hardcoding it. This keeps the design system as the single source of truth.
