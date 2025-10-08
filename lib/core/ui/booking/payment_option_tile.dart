import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

/// A reusable tile for selecting a payment method.
class PaymentOptionTile<T> extends StatelessWidget {
  /// Label for the payment option
  final String label;

  /// Icon for the payment option
  final IconData icon;

  /// Value represented by this tile
  final T value;

  /// Currently selected value in the group
  final T? groupValue;

  /// Callback when tile is selected
  final ValueChanged<T> onChanged;

  const PaymentOptionTile({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return AppCard(
      onTap: () => onChanged(value),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      margin: EdgeInsets.zero,
      borderRadius: AppRadius.mdRadius,
      border: Border.all(
        color: isSelected ? AppColors.primary : AppColors.border,
        width: 1.5,
      ),
      color: isSelected
          ? AppColors.primary.withValues(alpha: 0.02)
          : AppColors.surface,
      elevation: isSelected ? 2 : 0,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.primaryLighter.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected ? AppColors.onPrimary : AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              label,
              style: AppTypography.titleMedium.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.onSurface,
              ),
            ),
          ),
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: (val) => val != null ? onChanged(val) : null,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
