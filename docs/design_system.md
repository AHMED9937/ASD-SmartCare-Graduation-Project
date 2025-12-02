# Design System

## Overview

The design system provides a consistent visual language across the ASD SmartCare app through centralized tokens and reusable components.

## Design Tokens

Located in `lib/core/design_system/tokens/`:

### Colors (`colors.dart`)

```dart
abstract final class AppColors {
  // Primary palette
  static const Color primary = Color(0xFF67C8E4);
  static const Color primaryDark = Color(0xFF4BA8C4);
  static const Color primaryLight = Color(0xFF8FD8EE);
  
  // Semantic colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F5F5);
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF4CAF50);
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
}
```

### Typography (`typography.dart`)

```dart
abstract final class AppTypography {
  static const TextStyle displayLarge = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
  static const TextStyle titleLarge = TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  static const TextStyle bodyLarge = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);
  static const TextStyle bodyMedium = TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
  static const TextStyle bodySmall = TextStyle(fontSize: 12, fontWeight: FontWeight.normal);
  static const TextStyle labelLarge = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
}
```

### Spacing (`spacing.dart`)

```dart
abstract final class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}
```

### Radius (`radius.dart`)

```dart
abstract final class AppRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double circular = 999.0;
}
```

## Theme Integration

`lib/core/design_system/theme.dart` assembles tokens into `ThemeData`:

```dart
ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      surface: AppColors.surface,
      error: AppColors.error,
    ),
    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge,
      titleLarge: AppTypography.titleLarge,
      bodyLarge: AppTypography.bodyLarge,
    ),
    // ...
  );
}
```

## Shared UI Components

Components are organized in `lib/core/ui/` with a barrel export:

```dart
import 'package:asdsmartcare/core/ui/ui.dart';
```

### Directory Structure

```
lib/core/ui/
├── ui.dart              # Barrel export (import this)
├── app_bar/
│   └── app_header.dart  # App bar component
├── buttons/
│   ├── app_button.dart      # Primary/secondary/text buttons
│   └── app_icon_button.dart # Icon-only buttons
├── cards/
│   └── app_card.dart    # Card container
├── containers/
│   ├── app_divider.dart        # Divider lines
│   ├── app_spacer.dart         # Spacing utilities
│   └── responsive_container.dart # Width constraints
├── search/
│   └── app_search_field.dart   # Search input
├── states/
│   ├── empty_view.dart   # Empty state
│   ├── error_view.dart   # Error with retry
│   └── loading_view.dart # Loading indicator
└── text_fields/
    ├── app_dropdown_field.dart # Dropdown selection
    └── app_text_field.dart     # Text input
```

### Buttons (`lib/core/ui/buttons/app_button.dart`)

```dart
// Primary button
AppButton.primary(
  label: 'Sign In',
  onPressed: () => ...,
);

// Secondary button
AppButton.secondary(
  label: 'Cancel',
  onPressed: () => ...,
);
```

### Text Fields (`lib/core/ui/text_fields/app_text_field.dart`)

```dart
AppTextField(
  label: 'Email',
  controller: emailController,
  validator: (v) => v?.isEmpty == true ? 'Required' : null,
);
```

### State Views (`lib/core/ui/states/`)

```dart
// Loading
LoadingView(message: 'Please wait...');

// Error with retry
ErrorView(
  message: 'Something went wrong',
  onRetry: () => cubit.reload(),
);

// Empty state
EmptyView(
  icon: Icons.search_off,
  title: 'No results',
  subtitle: 'Try a different search term',
);
```

## Usage Guidelines

1. **Always use tokens** - Never hardcode colors, sizes, or fonts
2. **Prefer shared components** - Use `AppButton`, `AppTextField`, state views
3. **Theme-driven** - Access values via `Theme.of(context)` when needed
4. **Consistent spacing** - Use `AppSpacing` constants for all margins/padding
5. **Semantic colors** - Use `error`, `success`, `warning` not red/green/yellow

## Migration Status

### Completed

**Design Token Integration**
- ✅ Login screen
- ✅ Booking screen
- ✅ Booking confirmation
- ✅ Select role screen
- ✅ Password changed screen

**Component Consolidation (002-ui-consolidation)**
- ✅ Containers (AppSpacer, AppDivider, ResponsiveContainer)
- ✅ Buttons (AppButton, AppIconButton)
- ✅ Text Fields (AppTextField, AppDropdownField)
- ✅ State Views (LoadingView, ErrorView, EmptyView)
- ✅ State Management (lib/core/state/)

### Deprecation Wrappers

Legacy imports from `core/widgets/layouts/` still work but show deprecation warnings:

```dart
// ⚠️ Deprecated - will show warning
import 'package:asdsmartcare/core/widgets/layouts/app_buttons.dart';

// ✅ Recommended
import 'package:asdsmartcare/core/ui/ui.dart';
```

See [Components Guide](components.md) for migration examples.

## File Naming

- Use `snake_case` for file names
- Use `PascalCase` for class names
- Assets should be in `assets/` with snake_case names
