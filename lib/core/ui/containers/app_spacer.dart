import 'package:flutter/material.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// Vertical spacer widget using design system spacing tokens.
///
/// Usage:
/// ```dart
/// Column(children: [
///   Text('First'),
///   AppSpacer.sm(),  // 8dp gap
///   Text('Second'),
///   AppSpacer.lg(),  // 24dp gap
///   Text('Third'),
/// ])
/// ```
class AppSpacer extends StatelessWidget {
  /// The height of the spacer (vertical spacing)
  final double height;

  /// The width of the spacer (horizontal spacing)
  final double width;

  const AppSpacer({
    super.key,
    this.height = 0,
    this.width = 0,
  });

  /// Extra extra small vertical spacer (2dp)
  const AppSpacer.xxs({super.key})
      : height = AppSpacing.xxs,
        width = 0;

  /// Extra small vertical spacer (4dp)
  const AppSpacer.xs({super.key})
      : height = AppSpacing.xs,
        width = 0;

  /// Small vertical spacer (8dp)
  const AppSpacer.sm({super.key})
      : height = AppSpacing.sm,
        width = 0;

  /// Medium vertical spacer (16dp) - default
  const AppSpacer.md({super.key})
      : height = AppSpacing.md,
        width = 0;

  /// Large vertical spacer (24dp)
  const AppSpacer.lg({super.key})
      : height = AppSpacing.lg,
        width = 0;

  /// Extra large vertical spacer (32dp)
  const AppSpacer.xl({super.key})
      : height = AppSpacing.xl,
        width = 0;

  /// Extra extra large vertical spacer (48dp)
  const AppSpacer.xxl({super.key})
      : height = AppSpacing.xxl,
        width = 0;

  /// Horizontal extra small spacer (4dp)
  const AppSpacer.horizontalXs({super.key})
      : height = 0,
        width = AppSpacing.xs;

  /// Horizontal small spacer (8dp)
  const AppSpacer.horizontalSm({super.key})
      : height = 0,
        width = AppSpacing.sm;

  /// Horizontal medium spacer (16dp)
  const AppSpacer.horizontalMd({super.key})
      : height = 0,
        width = AppSpacing.md;

  /// Horizontal large spacer (24dp)
  const AppSpacer.horizontalLg({super.key})
      : height = 0,
        width = AppSpacing.lg;

  /// Horizontal extra large spacer (32dp)
  const AppSpacer.horizontalXl({super.key})
      : height = 0,
        width = AppSpacing.xl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
