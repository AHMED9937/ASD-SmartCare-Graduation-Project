# UI Components Guide

This guide documents the reusable UI components in the ASD SmartCare app.

## Quick Start

Import all UI components:

```dart
import 'package:asdsmartcare/core/ui/ui.dart';
```

## Component Categories

### 1. Containers

Layout utilities and structural components.

#### AppSpacer

Vertical and horizontal spacing using design tokens.

```dart
Column(
  children: [
    Text('First'),
    AppSpacer.sm(),   // 8dp gap
    Text('Second'),
    AppSpacer.lg(),   // 24dp gap
    Text('Third'),
  ],
)

// Horizontal spacing
Row(
  children: [
    Icon(Icons.star),
    AppSpacer.horizontal.sm(),
    Text('Rating'),
  ],
)
```

**Size variants**: `xxs` (2dp), `xs` (4dp), `sm` (8dp), `md` (16dp), `lg` (24dp), `xl` (32dp), `xxl` (48dp)

#### AppDivider

Consistent divider lines.

```dart
AppDivider()           // Full-width divider
AppDivider.indent()    // Indented divider (16dp start)
```

#### ResponsiveContainer

Width-constrained container for responsive layouts.

```dart
ResponsiveContainer(
  maxWidth: 600,
  child: MyForm(),
)

// Predefined sizes
ResponsiveContainer.narrow(child: MyForm())   // 480dp max
ResponsiveContainer.medium(child: MyForm())   // 720dp max
ResponsiveContainer.wide(child: MyForm())     // 960dp max
```

---

### 2. Buttons

Interactive button components.

#### AppButton

Primary, secondary, and text button variants.

```dart
// Primary button (filled)
AppButton(
  label: 'Submit',
  onPressed: () => handleSubmit(),
)

// Secondary button (outlined)
AppButton.secondary(
  label: 'Cancel',
  onPressed: () => Navigator.pop(context),
)

// Text button
AppButton.text(
  label: 'Learn More',
  onPressed: () => showDetails(),
)

// Size variants
AppButton(label: 'Small', size: AppButtonSize.small)    // 36dp height
AppButton(label: 'Medium', size: AppButtonSize.medium)  // 44dp height (default)
AppButton(label: 'Large', size: AppButtonSize.large)    // 56dp height

// Loading state
AppButton(
  label: 'Processing...',
  onPressed: null,
  isLoading: true,
)
```

#### AppIconButton

Icon-only buttons with consistent sizing.

```dart
AppIconButton(
  icon: Icons.add,
  onPressed: () => addItem(),
)

AppIconButton(
  icon: Icons.delete,
  onPressed: () => deleteItem(),
  color: AppColors.error,
)
```

---

### 3. Text Fields

Form input components.

#### AppTextField

Text input with validation support.

```dart
AppTextField(
  label: 'Email',
  hint: 'Enter your email',
  controller: _emailController,
  keyboardType: TextInputType.emailAddress,
  validator: (value) => value?.isEmpty == true ? 'Required' : null,
)

// Password field
AppTextField(
  label: 'Password',
  obscureText: true,
  controller: _passwordController,
)

// Multiline
AppTextField(
  label: 'Notes',
  maxLines: 4,
  controller: _notesController,
)
```

#### AppDropdownField

Dropdown selection field.

```dart
AppDropdownField<String>(
  label: 'Country',
  value: selectedCountry,
  items: ['USA', 'Canada', 'UK'],
  onChanged: (value) => setState(() => selectedCountry = value),
)
```

---

### 4. Cards

Content containers.

#### AppCard

Card with elevation and padding options.

```dart
AppCard(
  child: Column(
    children: [
      Text('Card Title'),
      AppSpacer.sm(),
      Text('Card content goes here'),
    ],
  ),
)

// With tap action
AppCard(
  onTap: () => showDetails(),
  child: ListTile(title: Text('Tappable Card')),
)
```

---

### 5. State Views

Loading, error, and empty state displays.

#### LoadingView

```dart
LoadingView()                          // Default spinner
LoadingView(message: 'Loading...')     // With message
```

#### ErrorView

```dart
ErrorView(
  message: 'Failed to load data',
  onRetry: () => loadData(),
)
```

#### EmptyView

```dart
EmptyView(
  message: 'No items found',
  action: AppButton(
    label: 'Add Item',
    onPressed: () => addItem(),
  ),
)
```

---

## Design Token Usage

All components use design tokens from `core/design_system/tokens/`:

| Token | Class | Example |
|-------|-------|---------|
| Colors | `AppColors` | `AppColors.primary`, `AppColors.error` |
| Spacing | `AppSpacing` | `AppSpacing.sm` (8dp), `AppSpacing.md` (16dp) |
| Typography | `AppTypography` | `AppTypography.bodyMedium` |
| Radius | `AppRadius` | `AppRadius.sm`, `AppRadius.md` |

---

## Migration from Legacy Components

### Before (deprecated)

```dart
import 'package:asdsmartcare/core/widgets/layouts/app_buttons.dart';
import 'package:asdsmartcare/core/widgets/layouts/fixed_widgets.dart';

MyButton(text: 'Click', onPressed: () {})
SizedBox(height: 16)
```

### After

```dart
import 'package:asdsmartcare/core/ui/ui.dart';

AppButton(label: 'Click', onPressed: () {})
AppSpacer.md()
```

---

## Accessibility

All components support:

- **Semantic labels** via `semanticLabel` parameter
- **High contrast** via design token colors
- **Touch targets** minimum 48dp for buttons
- **Focus indicators** for keyboard navigation

---

## Related Documentation

- [Design System](design_system.md) - Token definitions and theming
- [Architecture](architecture.md) - Overall app structure
