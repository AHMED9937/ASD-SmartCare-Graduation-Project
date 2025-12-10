import 'package:flutter/material.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// Styled divider widget using design system tokens.
///
/// Usage:
/// ```dart
/// Column(children: [
///   ListTile(title: Text('Item 1')),
///   AppDivider(),
///   ListTile(title: Text('Item 2')),
///   AppDivider.thick(),
///   ListTile(title: Text('Item 3')),
/// ])
/// ```
class AppDivider extends StatelessWidget {
  /// The thickness of the divider line
  final double thickness;

  /// The color of the divider (defaults to design system divider color)
  final Color? color;

  /// Horizontal indent from start
  final double indent;

  /// Horizontal indent from end
  final double endIndent;

  /// Height of the divider container (includes spacing above/below line)
  final double? height;

  const AppDivider({
    super.key,
    this.thickness = 1.0,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
    this.height,
  });

  /// Thin divider (0.5dp)
  const AppDivider.thin({
    super.key,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
    this.height,
  }) : thickness = 0.5;

  /// Default divider (1dp)
  const AppDivider.regular({
    super.key,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
    this.height,
  }) : thickness = 1.0;

  /// Thick divider (2dp)
  const AppDivider.thick({
    super.key,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
    this.height,
  }) : thickness = 2.0;

  /// Indented divider with standard screen padding
  const AppDivider.indented({
    super.key,
    this.thickness = 1.0,
    this.color,
    this.height,
  }) : indent = AppSpacing.screenPaddingH,
       endIndent = AppSpacing.screenPaddingH;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      color: color ?? AppColors.divider,
      indent: indent,
      endIndent: endIndent,
      height: height ?? AppSpacing.md,
    );
  }
}

/// Vertical divider using design system tokens.
///
/// Usage:
/// ```dart
/// Row(children: [
///   Text('Left'),
///   AppVerticalDivider(),
///   Text('Right'),
/// ])
/// ```
class AppVerticalDivider extends StatelessWidget {
  /// The thickness of the divider line
  final double thickness;

  /// The color of the divider
  final Color? color;

  /// Width of the divider container
  final double? width;

  /// Vertical indent from top
  final double indent;

  /// Vertical indent from bottom
  final double endIndent;

  const AppVerticalDivider({
    super.key,
    this.thickness = 1.0,
    this.color,
    this.width,
    this.indent = 0,
    this.endIndent = 0,
  });

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      thickness: thickness,
      color: color ?? AppColors.divider,
      width: width ?? AppSpacing.md,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
