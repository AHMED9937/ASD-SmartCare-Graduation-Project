import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// A badge widget for displaying test results with semantic colors.
///
/// Usage:
/// ```dart
/// ResultBadge.positive()
/// ResultBadge.negative()
/// ResultBadge.level(level: 2)
/// ```
class ResultBadge extends StatelessWidget {
  /// Badge icon
  final IconData icon;

  /// Badge label
  final String label;

  /// Badge color
  final Color color;

  /// Badge background color
  final Color? backgroundColor;

  /// Badge size
  final ResultBadgeSize size;

  const ResultBadge({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    this.backgroundColor,
    this.size = ResultBadgeSize.medium,
  });

  /// Create a positive result badge (no signs detected)
  const ResultBadge.positive({
    super.key,
    this.label = 'No Signs Detected',
    this.size = ResultBadgeSize.medium,
  })  : icon = Icons.check_circle_rounded,
        color = AppColors.success,
        backgroundColor = null;

  /// Create a negative result badge (signs detected)
  const ResultBadge.negative({
    super.key,
    this.label = 'Signs Detected',
    this.size = ResultBadgeSize.medium,
  })  : icon = Icons.warning_rounded,
        color = AppColors.warning,
        backgroundColor = null;

  /// Create a level indicator badge
  factory ResultBadge.level({
    Key? key,
    required int level,
    ResultBadgeSize size = ResultBadgeSize.medium,
  }) {
    final Color color;
    final String label;

    switch (level) {
      case 1:
        color = AppColors.success;
        label = 'Level 1 - Mild';
      case 2:
        color = AppColors.warning;
        label = 'Level 2 - Moderate';
      case 3:
        color = AppColors.error;
        label = 'Level 3 - Severe';
      default:
        color = AppColors.info;
        label = 'Level $level';
    }

    return ResultBadge(
      key: key,
      icon: Icons.analytics_rounded,
      label: label,
      color: color,
      size: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = _getDimensions();
    final effectiveBackgroundColor =
        backgroundColor ?? color.withValues(alpha: 0.12);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dimensions.horizontalPadding,
        vertical: dimensions.verticalPadding,
      ),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(dimensions.borderRadius),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: dimensions.iconSize,
            color: color,
          ),
          SizedBox(width: dimensions.spacing),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: dimensions.fontSize,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  _BadgeDimensions _getDimensions() {
    switch (size) {
      case ResultBadgeSize.small:
        return const _BadgeDimensions(
          iconSize: 16,
          fontSize: 12,
          horizontalPadding: 8,
          verticalPadding: 4,
          spacing: 4,
          borderRadius: 8,
        );
      case ResultBadgeSize.medium:
        return const _BadgeDimensions(
          iconSize: 20,
          fontSize: 14,
          horizontalPadding: 12,
          verticalPadding: 6,
          spacing: 6,
          borderRadius: 12,
        );
      case ResultBadgeSize.large:
        return const _BadgeDimensions(
          iconSize: 28,
          fontSize: 16,
          horizontalPadding: 16,
          verticalPadding: 10,
          spacing: 8,
          borderRadius: 16,
        );
    }
  }
}

enum ResultBadgeSize { small, medium, large }

class _BadgeDimensions {
  final double iconSize;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final double spacing;
  final double borderRadius;

  const _BadgeDimensions({
    required this.iconSize,
    required this.fontSize,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.spacing,
    required this.borderRadius,
  });
}
