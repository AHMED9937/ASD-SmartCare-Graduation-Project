# Design Tokens Reference

**Generated**: 2025-12-16 | **Task**: T004

## Token Files Location

```
lib/core/design_system/
├── theme.dart           # ThemeData configuration
└── tokens/
    ├── tokens.dart      # Barrel export
    ├── colors.dart      # AppColors
    ├── spacing.dart     # AppSpacing
    ├── typography.dart  # AppTypography
    └── radius.dart      # AppRadius
```

---

## Import Pattern

```dart
// Single import for all tokens
import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
```

---

## AppColors (133 lines)

### Brand Colors
| Token | Value | Usage |
|-------|-------|-------|
| `AppColors.primary` | `#133E87` | Primary buttons, headers |
| `AppColors.primaryLight` | `#3A5F9A` | Hover states |
| `AppColors.primaryDark` | `#0D2A5C` | Pressed states |
| `AppColors.secondary` | `#608BC1` | Secondary buttons |
| `AppColors.secondaryLight` | `#8AABD4` | Secondary hover |
| `AppColors.secondaryDark` | `#3D6A9E` | Secondary pressed |

### Semantic Colors
| Token | Value | Usage |
|-------|-------|-------|
| `AppColors.success` | `#28A745` | Success states |
| `AppColors.successLight` | `#D4EDDA` | Success backgrounds |
| `AppColors.warning` | `#FFC107` | Warning states |
| `AppColors.warningLight` | `#FFF3CD` | Warning backgrounds |
| `AppColors.error` | `#DC3545` | Error states, validation |
| `AppColors.errorLight` | `#F8D7DA` | Error backgrounds |
| `AppColors.info` | `#17A2B8` | Info states |
| `AppColors.infoLight` | `#D1ECF1` | Info backgrounds |

### Surface & Background
| Token | Value | Usage |
|-------|-------|-------|
| `AppColors.background` | `#F5F5F5` | Main background |
| `AppColors.surface` | `#FFFFFF` | Cards, sheets |
| `AppColors.scaffoldBackground` | `#FFFFFF` | Scaffold |

### Text & Icons
| Token | Value | Usage |
|-------|-------|-------|
| `AppColors.onPrimary` | `#FFFFFF` | Text on primary |
| `AppColors.onSecondary` | `#FFFFFF` | Text on secondary |
| `AppColors.onBackground` | `#1A1A1A` | Text on background |
| `AppColors.onSurface` | `#1A1A1A` | Text on surface |

---

## AppSpacing (120 lines)

### Spacing Scale (based on 4dp)
| Token | Value | Common Usage |
|-------|-------|--------------|
| `AppSpacing.xxs` | 2dp | Micro gaps |
| `AppSpacing.xs` | 4dp | Icon-text gaps |
| `AppSpacing.sm` | 8dp | List item spacing |
| `AppSpacing.md` | 16dp | Default padding |
| `AppSpacing.lg` | 24dp | Section gaps |
| `AppSpacing.xl` | 32dp | Major sections |
| `AppSpacing.xxl` | 48dp | Large gaps |
| `AppSpacing.xxxl` | 64dp | Hero spacing |

### Semantic Spacing
| Token | Value | Usage |
|-------|-------|-------|
| `AppSpacing.screenPaddingH` | 16dp | Screen horizontal edge |
| `AppSpacing.screenPaddingV` | 16dp | Screen vertical edge |
| `AppSpacing.cardPadding` | 16dp | Inside cards |
| `AppSpacing.listItemSpacing` | 8dp | Between list items |
| `AppSpacing.sectionSpacing` | 32dp | Between sections |
| `AppSpacing.formFieldSpacing` | 16dp | Between form fields |
| `AppSpacing.buttonPaddingH` | 16dp | Button horizontal |
| `AppSpacing.buttonPaddingV` | 8dp | Button vertical |
| `AppSpacing.iconTextGap` | 8dp | Icon to text gap |

---

## AppTypography (190 lines)

### Display Styles (Hero sections)
| Token | Size | Weight |
|-------|------|--------|
| `AppTypography.displayLarge` | 57px | Regular |
| `AppTypography.displayMedium` | 45px | Regular |
| `AppTypography.displaySmall` | 36px | Regular |

### Headline Styles (Page titles)
| Token | Size | Weight |
|-------|------|--------|
| `AppTypography.headlineLarge` | 32px | SemiBold |
| `AppTypography.headlineMedium` | 28px | SemiBold |
| `AppTypography.headlineSmall` | 24px | SemiBold |

### Title Styles (Card titles)
| Token | Size | Weight |
|-------|------|--------|
| `AppTypography.titleLarge` | 22px | Medium |
| `AppTypography.titleMedium` | 16px | Medium |
| `AppTypography.titleSmall` | 14px | Medium |

### Body Styles (Content)
| Token | Size | Weight |
|-------|------|--------|
| `AppTypography.bodyLarge` | 16px | Regular |
| `AppTypography.bodyMedium` | 14px | Regular |
| `AppTypography.bodySmall` | 12px | Regular |

### Label Styles (Buttons, chips)
| Token | Size | Weight |
|-------|------|--------|
| `AppTypography.labelLarge` | 14px | Medium |
| `AppTypography.labelMedium` | 12px | Medium |
| `AppTypography.labelSmall` | 11px | Medium |

---

## AppRadius (97 lines)

### Radius Values
| Token | Value | Usage |
|-------|-------|-------|
| `AppRadius.none` | 0dp | Sharp corners |
| `AppRadius.xs` | 4dp | Small chips |
| `AppRadius.sm` | 8dp | Buttons |
| `AppRadius.md` | 12dp | Cards (default) |
| `AppRadius.lg` | 16dp | Modals |
| `AppRadius.xl` | 24dp | Large cards |
| `AppRadius.full` | 9999dp | Pills, circles |

### BorderRadius Objects (Pre-built)
| Token | Type |
|-------|------|
| `AppRadius.noneRadius` | `BorderRadius.zero` |
| `AppRadius.xsRadius` | `BorderRadius.circular(4)` |
| `AppRadius.smRadius` | `BorderRadius.circular(8)` |
| `AppRadius.mdRadius` | `BorderRadius.circular(12)` |
| `AppRadius.lgRadius` | `BorderRadius.circular(16)` |
| `AppRadius.xlRadius` | `BorderRadius.circular(24)` |

---

## Migration Mapping

### Legacy Hardcoded → Design Token

| Legacy Value | Design Token Replacement |
|--------------|-------------------------|
| `Color(0xFF133E87)` | `AppColors.primary` |
| `Color(0xFFB5B1B1)` | `AppColors.border` or create if missing |
| `Color(0xFF082F71)` | `AppColors.primaryDark` |
| `BorderRadius.circular(11)` | `AppRadius.mdRadius` |
| `BorderRadius.circular(20)` | `AppRadius.xlRadius` |
| `EdgeInsets.symmetric(vertical: 16.5, horizontal: 19)` | `EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.md)` |
| `EdgeInsets.all(8.0)` | `EdgeInsets.all(AppSpacing.sm)` |
| `toolbarHeight: 80` | Create semantic constant or keep as-is |
| `fontSize: 24` | `AppTypography.headlineSmall` |
| `fontSize: 22` | `AppTypography.titleLarge` |
| `fontSize: 16` | `AppTypography.bodyLarge` |

---

## Usage Examples

### Button with Design Tokens
```dart
ElevatedButton(
  onPressed: onPressed,
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    padding: EdgeInsets.symmetric(
      horizontal: AppSpacing.buttonPaddingH,
      vertical: AppSpacing.buttonPaddingV,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.smRadius,
    ),
  ),
  child: Text(label, style: AppTypography.labelLarge),
)
```

### Text Field with Design Tokens
```dart
TextFormField(
  decoration: InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      vertical: AppSpacing.md,
      horizontal: AppSpacing.md,
    ),
    border: OutlineInputBorder(
      borderRadius: AppRadius.xlRadius,
      borderSide: BorderSide(color: AppColors.border ?? AppColors.onSurface.withOpacity(0.12)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: AppRadius.xlRadius,
      borderSide: BorderSide(color: AppColors.error),
    ),
  ),
)
```

### Container with Design Tokens
```dart
Container(
  padding: EdgeInsets.all(AppSpacing.cardPadding),
  decoration: BoxDecoration(
    color: AppColors.surface,
    borderRadius: AppRadius.mdRadius,
    boxShadow: [
      BoxShadow(
        color: AppColors.onSurface.withOpacity(0.1),
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  ),
)
```
