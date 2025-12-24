import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

class FeedbackCard extends StatelessWidget {
  final String comment;
  final String timestamp;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const FeedbackCard({
    super.key,
    required this.comment,
    required this.timestamp,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Feedback: $comment',
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    comment,
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
                _buildMenu(context),
              ],
            ),
            if (timestamp.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                timestamp,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert_rounded,
        size: 20,
        color: AppColors.textSecondary,
      ),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.mdRadius),
      onSelected: (value) {
        if (value == 'edit') {
          onEdit();
        } else if (value == 'delete') {
          onDelete();
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 18),
              SizedBox(width: AppSpacing.sm),
              Text('Edit', style: AppTypography.bodyMedium),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              const Icon(Icons.delete_outline_rounded,
                  size: 18, color: AppColors.error),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Delete',
                style:
                    AppTypography.bodyMedium.copyWith(color: AppColors.error),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
