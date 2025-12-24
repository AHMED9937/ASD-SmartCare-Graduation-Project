# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **UI Component System** (`lib/core/ui/`)
  - `containers/`: AppSpacer, AppDivider, ResponsiveContainer
  - `buttons/`: AppButton (primary/secondary/text), AppIconButton
  - `text_fields/`: AppTextField, AppDropdownField
  - `states/`: LoadingView, ErrorView, EmptyView
  - Barrel export via `lib/core/ui/ui.dart`

- **State Management Separation** (`lib/core/state/`)
  - Moved AsdCubit, AsdStates, MyBlocObserver from widgets/
  - Barrel export via `lib/core/state/state.dart`

- **Documentation**
  - `docs/components.md`: Usage guide with examples
  - Updated `docs/design_system.md` with new organization

### Changed

- All UI components now use design system tokens (AppColors, AppSpacing, AppTypography, AppRadius)
- Components support responsive sizing (small, medium, large)

### Deprecated

- `lib/core/widgets/layouts/` - Use `lib/core/ui/` instead
  - `app_buttons.dart` → `lib/core/ui/buttons/`
  - `fixed_widgets.dart` → `lib/core/ui/containers/`
  - `app_form_text_field.dart` → `lib/core/ui/text_fields/`
  - `stateless_app_text_form_field.dart` → `lib/core/ui/text_fields/`

- `lib/core/widgets/app_cubit.dart` → `lib/core/state/app_cubit.dart`
- `lib/core/widgets/app_state.dart` → `lib/core/state/app_state.dart`
- `lib/core/widgets/bloc_observer.dart` → `lib/core/state/bloc_observer.dart`

### Migration Guide

Update imports from:
```dart
import 'package:asdsmartcare/core/widgets/layouts/app_buttons.dart';
```

To:
```dart
import 'package:asdsmartcare/core/ui/ui.dart';
```

Deprecation warnings will guide migration. See `docs/components.md` for examples.
