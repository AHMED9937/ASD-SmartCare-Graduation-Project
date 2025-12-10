import 'package:flutter/material.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// Reusable card component following design system tokens.
///
/// Usage:
/// ```dart
/// AppCard(
///   child: Text('Card content'),
/// )
///
/// AppCard(
///   onTap: () => Navigator.push(...),
///   child: ListTile(title: Text('Tappable card')),
/// )
/// ```
class AppCard extends StatelessWidget {
  /// Card content
  final Widget child;

  /// Callback when card is tapped
  final VoidCallback? onTap;

  /// Card padding
  final EdgeInsetsGeometry? padding;

  /// Card margin
  final EdgeInsetsGeometry? margin;

  /// Card elevation
  final double? elevation;

  /// Card border radius
  final BorderRadius? borderRadius;

  /// Card background color
  final Color? color;

  /// Card background gradient
  final Gradient? gradient;

  /// Card border
  final Border? border;

  /// Whether card should have shadow
  final bool hasShadow;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.elevation,
    this.borderRadius,
    this.color,
    this.gradient,
    this.border,
    this.hasShadow = true,
  });

  /// Create a card with no elevation (flat)
  const AppCard.flat({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.gradient,
    this.border,
  }) : elevation = 0,
       hasShadow = false;

  /// Create a card with outline border
  const AppCard.outlined({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.gradient,
  }) : elevation = 0,
       hasShadow = false,
       border = const Border.fromBorderSide(
         BorderSide(color: AppColors.border),
       );

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? AppRadius.card;
    final effectiveElevation = elevation ?? (hasShadow ? 1 : 0);
    final effectiveColor = color ?? AppColors.surface;
    final effectivePadding =
        padding ?? const EdgeInsets.all(AppSpacing.cardPadding);
    final effectiveMargin = margin ?? const EdgeInsets.all(AppSpacing.sm);

    Widget card = Container(
      margin: effectiveMargin,
      decoration: BoxDecoration(
        color: effectiveColor,
        gradient: gradient,
        borderRadius: effectiveBorderRadius,
        border: border,
        boxShadow: hasShadow && effectiveElevation > 0
            ? [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: effectiveElevation * 2,
                  offset: Offset(0, effectiveElevation),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: Padding(padding: effectivePadding, child: child),
      ),
    );

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: effectiveBorderRadius,
        child: card,
      );
    }

    return card;
  }
}
