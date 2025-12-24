import 'package:flutter/material.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// App button styles
enum AppButtonStyle {
  /// Primary filled button
  primary,

  /// Secondary outlined button
  secondary,

  /// Text-only button
  text,
}

/// App button sizes for responsive layouts
enum AppButtonSize {
  /// Small button (height: 36dp)
  small,

  /// Medium button (height: 44dp) - default
  medium,

  /// Large button (height: 56dp)
  large,
}

/// Reusable button component following design system tokens.
///
/// Usage:
/// ```dart
/// AppButton(
///   label: 'Submit',
///   onPressed: () => print('Pressed'),
/// )
///
/// AppButton.secondary(
///   label: 'Cancel',
///   onPressed: () => Navigator.pop(context),
/// )
///
/// // Size variants
/// AppButton(label: 'Small', size: AppButtonSize.small)
/// AppButton(label: 'Large', size: AppButtonSize.large)
/// ```
class AppButton extends StatelessWidget {
  /// Button label text
  final String label;

  /// Callback when button is pressed. Null disables the button.
  final VoidCallback? onPressed;

  /// Button style variant
  final AppButtonStyle style;

  /// Button size variant
  final AppButtonSize size;

  /// Whether button is in loading state
  final bool isLoading;

  /// Optional leading icon
  final IconData? icon;

  /// Whether button should expand to full width
  final bool expanded;

  /// Optional text color override
  final Color? textColor;

  /// Optional background color override
  final Color? backgroundColor;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.style = AppButtonStyle.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.expanded = true,
    this.textColor,
    this.backgroundColor,
  });

  /// Create a primary (filled) button
  const AppButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.expanded = true,
    this.textColor,
    this.backgroundColor,
  }) : style = AppButtonStyle.primary;

  /// Create a secondary (outlined) button
  const AppButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.expanded = true,
    this.textColor,
    this.backgroundColor,
  }) : style = AppButtonStyle.secondary;

  /// Create a text button
  const AppButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.expanded = false,
    this.textColor,
    this.backgroundColor,
  }) : style = AppButtonStyle.text;

  @override
  Widget build(BuildContext context) {
    final child = _buildChild();
    final buttonHeight = _getButtonHeight();

    Widget button;
    switch (style) {
      case AppButtonStyle.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: backgroundColor != null
              ? ElevatedButton.styleFrom(backgroundColor: backgroundColor)
              : null,
          child: child,
        );
      case AppButtonStyle.secondary:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: backgroundColor != null
              ? OutlinedButton.styleFrom(backgroundColor: backgroundColor)
              : null,
          child: child,
        );
      case AppButtonStyle.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: backgroundColor != null
              ? TextButton.styleFrom(backgroundColor: backgroundColor)
              : null,
          child: child,
        );
    }

    if (expanded) {
      return SizedBox(
        width: double.infinity,
        height: buttonHeight,
        child: button,
      );
    }

    return SizedBox(
      height: buttonHeight,
      child: button,
    );
  }

  double _getButtonHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 32.0;
      case AppButtonSize.medium:
        return 40.0;
      case AppButtonSize.large:
        return 48.0;
    }
  }

  Widget _buildChild() {
    if (isLoading) {
      return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 20, maxWidth: 20),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            style == AppButtonStyle.primary
                ? AppColors.onPrimary
                : AppColors.primary,
          ),
        ),
      );
    }

    final textWidget = Text(
      label,
      style: textColor != null ? TextStyle(color: textColor) : null,
    );

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: AppSpacing.iconSm, color: textColor),
          const SizedBox(width: AppSpacing.iconTextGap),
          textWidget,
        ],
      );
    }

    return textWidget;
  }
}
