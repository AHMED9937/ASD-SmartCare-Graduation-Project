import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

class DayAvailabilityCard extends StatelessWidget {
  final String day;
  final bool isActive;
  final DateTime? selectedDate;
  final List<TimeOfDay> selectedTimes;
  final VoidCallback onToggleActive;
  final VoidCallback onPickDate;
  final VoidCallback onAddTime;
  final Function(int) onDeleteTime;

  const DayAvailabilityCard({
    super.key,
    required this.day,
    required this.isActive,
    required this.selectedDate,
    required this.selectedTimes,
    required this.onToggleActive,
    required this.onPickDate,
    required this.onAddTime,
    required this.onDeleteTime,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day,
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isActive ? AppColors.primary : AppColors.onSurface,
                ),
              ),
              Semantics(
                label: 'Toggle availability for $day',
                child: Switch.adaptive(
                  value: isActive,
                  onChanged: (_) => onToggleActive(),
                  activeColor: AppColors.primary,
                ),
              ),
            ],
          ),
          if (isActive) ...[
            const AppDivider(height: AppSpacing.md),
            _buildDetailTile(
              context,
              icon: Icons.calendar_today_outlined,
              label: 'Selected Date',
              value: selectedDate != null
                  ? '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}'
                  : 'No date selected',
              onTap: onPickDate,
            ),
            const SizedBox(height: AppSpacing.md),
            SectionHeader(
              title: 'Time Slots',
              actionLabel: 'Add Slot',
              onActionPressed: onAddTime,
              padding: EdgeInsets.zero,
            ),
            if (selectedTimes.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Center(
                  child: Text(
                    'No slots added yet',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: selectedTimes.length,
                itemBuilder: (context, index) {
                  final time = selectedTimes[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            time.format(context),
                            style: AppTypography.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, size: 20),
                            color: AppColors.error,
                            onPressed: () => onDeleteTime(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: AppTypography.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
