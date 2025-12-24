import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/progress/models/session_model.dart';
import 'package:asdsmartcare/parent/progress/views/session_details_screen.dart';

/// A premium card to display session summary information.
class SessionCard extends StatelessWidget {
  final SessionData session;

  const SessionCard({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    final sessionNumber = session.sessionNumber ?? '';
    final comments = session.comments?.join('\n') ?? 'No comments available';

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SessionDetail(session: session),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Icon(
                  Icons.event_available,
                  size: AppSpacing.iconSm,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Session $sessionNumber',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: AppSpacing.iconMd,
                color: AppColors.textDisabled,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            comments,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.onSurface,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (session.createdAt != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              session.createdAt!,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
