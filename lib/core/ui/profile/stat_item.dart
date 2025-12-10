import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
import 'package:flutter/material.dart';

/// A small vertical widget for displaying metrics.
class StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const StatItem({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: AppSpacing.iconSm, color: AppColors.primary),
          const SizedBox(height: AppSpacing.xxs),
        ],
        Text(
          value,
          style: AppTypography.headlineSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
