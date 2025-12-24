# Breaking Changes - 002-ui-consolidation

This document lists breaking changes introduced by the UI Component System Consolidation feature.

## Summary

**No breaking changes** - All existing code continues to work via deprecation wrappers.

Deprecation warnings guide developers to migrate to new imports.

## Deprecation Wrappers

The following legacy imports are deprecated but still functional:

### From `lib/core/widgets/layouts/`

| Legacy Import | New Import | Deprecation Warning |
|---------------|------------|---------------------|
| `app_buttons.dart` | `lib/core/ui/ui.dart` | Use lib/core/ui/buttons/ instead |
| `fixed_widgets.dart` | `lib/core/ui/ui.dart` | Use lib/core/ui/ components instead |
| `app_form_text_field.dart` | `lib/core/ui/ui.dart` | Use lib/core/ui/text_fields/ instead |
| `stateless_app_text_form_field.dart` | `lib/core/ui/ui.dart` | Use lib/core/ui/text_fields/ instead |

### From `lib/core/widgets/`

| Legacy Import | New Import | Deprecation Warning |
|---------------|------------|---------------------|
| `app_cubit.dart` | `lib/core/state/state.dart` | Use lib/core/state/ instead |
| `app_state.dart` | `lib/core/state/state.dart` | Use lib/core/state/ instead |
| `bloc_observer.dart` | `lib/core/state/state.dart` | Use lib/core/state/ instead |

## Deprecated Classes/Functions

| Class/Function | Replacement | Migration |
|----------------|-------------|-----------|
| `AppButtons.containerTextButton()` | `AppButton()` | Use AppButton with label parameter |
| `AppButtons.arrowbutton()` | `AppIconButton.back()` | Use AppIconButton.back() |
| `AppBarWithText()` | `AppHeader.withTitle()` | Use AppHeader from lib/core/ui/app_bar/ |
| `NavgatTO()` | `Navigator.push()` | Use Flutter's Navigator directly |

## Migration Steps

1. **Update imports**:
   ```dart
   // Before
   import 'package:asdsmartcare/core/widgets/layouts/app_buttons.dart';
   
   // After
   import 'package:asdsmartcare/core/ui/ui.dart';
   ```

2. **Update class usage**:
   ```dart
   // Before
   AppButtons.containerTextButton(context, 'Submit', () {})
   
   // After
   AppButton(label: 'Submit', onPressed: () {})
   ```

## Timeline

- **Phase 1**: Deprecation wrappers deployed (current)
- **Phase 2**: Teams update imports (next sprint)
- **Phase 3**: Deprecation wrappers removed (future release)

## Testing

All 90 existing tests pass with deprecation wrappers in place.

Deprecation warnings appear in console during development:

```
info - 'package:asdsmartcare/core/widgets/layouts/app_buttons.dart' is deprecated
       and shouldn't be used. Use lib/core/ui/buttons/ instead.
```

## Questions

Contact the architecture team for migration assistance.
