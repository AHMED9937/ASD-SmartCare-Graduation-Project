import 'package:flutter/material.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// Icon button sizes
enum AppIconButtonSize {
  /// Small icon button (32dp)
  small,

  /// Medium icon button (40dp) - default
  medium,

  /// Large icon button (48dp)
  large,
}

/// Reusable icon button component following design system tokens.
///
/// Usage:
/// ```dart
/// // Back navigation button
/// AppIconButton.back(
///   onPressed: () => Navigator.pop(context),
/// )
///
/// // Custom icon button
/// AppIconButton(
///   icon: Icons.settings,
///   onPressed: () => openSettings(),
/// )
///
/// // Filled variant
/// AppIconButton.filled(
///   icon: Icons.add,
///   onPressed: () => addItem(),
/// )
/// ```
class AppIconButton extends StatelessWidget {
  /// The icon to display
  final IconData icon;

  /// Callback when button is pressed. Null disables the button.
  final VoidCallback? onPressed;

  /// The size of the icon button
  final AppIconButtonSize size;

  /// Icon color (defaults to primary)
  final Color? iconColor;

  /// Background color (for filled variant)
  final Color? backgroundColor;

  /// Whether the button has a filled background
  final bool filled;

  /// Optional tooltip text
  final String? tooltip;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = AppIconButtonSize.medium,
    this.iconColor,
    this.backgroundColor,
    this.filled = false,
    this.tooltip,
  });

  /// Create a back navigation button (arrow_back_ios icon).
  const AppIconButton.back({
    super.key,
    this.onPressed,
    this.size = AppIconButtonSize.medium,
    this.iconColor,
    this.tooltip = 'Back',
  })  : icon = Icons.arrow_back_ios_new_rounded,
        backgroundColor = null,
        filled = false;

  /// Create a close button (close icon).
  const AppIconButton.close({
    super.key,
    this.onPressed,
    this.size = AppIconButtonSize.medium,
    this.iconColor,
    this.tooltip = 'Close',
  })  : icon = Icons.close,
        backgroundColor = null,
        filled = false;

  /// Create a filled icon button.
  const AppIconButton.filled({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = AppIconButtonSize.medium,
    this.iconColor,
    this.backgroundColor,
    this.tooltip,
  }) : filled = true;

  @override
  Widget build(BuildContext context) {
    final buttonSize = _getButtonSize();
    final iconSize = _getIconSize();
    final effectiveIconColor = iconColor ?? AppColors.primary;

    Widget button;

    if (filled) {
      button = IconButton.filled(
        onPressed: onPressed,
        icon: Icon(icon, size: iconSize),
        iconSize: iconSize,
        color: iconColor ?? AppColors.onPrimary,
        style: IconButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          minimumSize: Size(buttonSize, buttonSize),
        ),
      );
    } else {
      button = IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: iconSize, color: effectiveIconColor),
        iconSize: iconSize,
        constraints: BoxConstraints(
          minWidth: buttonSize,
          minHeight: buttonSize,
        ),
      );
    }

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }

  double _getButtonSize() {
    switch (size) {
      case AppIconButtonSize.small:
        return 32.0;
      case AppIconButtonSize.medium:
        return 40.0;
      case AppIconButtonSize.large:
        return 48.0;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppIconButtonSize.small:
        return 18.0;
      case AppIconButtonSize.medium:
        return 24.0;
      case AppIconButtonSize.large:
        return 28.0;
    }
  }
}
