import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
import 'package:flutter/material.dart';

/// A reusable grid for selecting time slots.
///
/// Usage:
/// ```dart
/// TimeSlotGrid(
///   slots: ['09:00 AM', '10:00 AM', ...],
///   selectedSlot: _selected,
///   onSlotSelected: (slot) => setState(() => _selected = slot),
/// )
/// ```
class TimeSlotGrid extends StatelessWidget {
  /// List of available time slots as strings
  final List<String> slots;

  /// Currently selected time slot
  final String? selectedSlot;

  /// Callback when a slot is tapped
  final ValueChanged<String?> onSlotSelected;

  /// Whether the grid is interactive
  final bool enabled;

  const TimeSlotGrid({
    super.key,
    required this.slots,
    required this.selectedSlot,
    required this.onSlotSelected,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) {
      return Center(
        child: Text(
          'No available times.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    // Adaptive grid based on screen width
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600
            ? 6
            : (constraints.maxWidth < 360 ? 3 : 4);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 2.2,
          ),
          itemCount: slots.length,
          itemBuilder: (context, index) {
            final time = slots[index];
            final isSelected = selectedSlot == time;

            return _SlotItem(
              time: time,
              isSelected: isSelected,
              enabled: enabled,
              onTap: () => onSlotSelected(isSelected ? null : time),
            );
          },
        );
      },
    );
  }
}

class _SlotItem extends StatelessWidget {
  final String time;
  final bool isSelected;
  final bool enabled;
  final VoidCallback onTap;

  const _SlotItem({
    required this.time,
    required this.isSelected,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: AppRadius.smRadius,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: AppRadius.smRadius,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
          boxShadow: isSelected ? [AppShadows.xs] : null,
        ),
        child: Text(
          time,
          style: AppTypography.labelMedium.copyWith(
            color: isSelected
                ? AppColors.onPrimary
                : (enabled ? AppColors.primary : AppColors.textDisabled),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
