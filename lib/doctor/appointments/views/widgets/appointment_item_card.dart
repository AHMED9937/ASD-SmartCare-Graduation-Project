import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

class AppointmentItemCard extends StatelessWidget {
  final dynamic appointment;

  const AppointmentItemCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final status = (appointment.status ?? '').toString().toLowerCase();
    final isCancelled = status == 'cancelled';
    final isBooked = status == 'booked';

    final statusColor = isBooked
        ? AppColors.success
        : isCancelled
        ? AppColors.error
        : AppColors.primary;

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Status Indicator
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appointment.time ?? '--:--',
                          style: AppTypography.titleLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        StatusBadge(status: status, color: statusColor),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${appointment.day ?? ''}',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;
  final Color color;

  const StatusBadge({super.key, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppTypography.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
