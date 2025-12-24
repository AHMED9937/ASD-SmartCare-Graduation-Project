import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

class SessionCard extends StatelessWidget {
  final String? childName;
  final String? age;
  final String? gender;
  final DateTime? date;
  final VoidCallback onTap;

  const SessionCard({
    super.key,
    this.childName,
    this.age,
    this.gender,
    this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = childName ?? 'No child';
    final details = <String>[];
    if (age != null) details.add('$age years');
    if (gender != null) details.add(gender!);
    final infoLine = details.join(' • ');

    final dateStr = date != null ? DateFormat('dd MMM yyyy').format(date!) : '';
    final timeStr = date != null ? DateFormat('hh:mm a').format(date!) : '';

    return Semantics(
      label: 'Session for $displayName',
      button: true,
      hint: 'Tap to view session details',
      excludeSemantics: true,
      child: AppCard(
        onTap: onTap,
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              _buildAvatar(),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (infoLine.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        infoLine,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              _buildDateTime(dateStr, timeStr),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.child_care_rounded,
          color: AppColors.primary,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildDateTime(String dateStr, String timeStr) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (dateStr.isNotEmpty)
          Text(
            dateStr,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        if (timeStr.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            timeStr,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
