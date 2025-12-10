import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

/// Animated header displaying test progress with visual indicators.
///
/// Features:
/// - Animated circular progress ring
/// - Question counter with smooth transition
/// - Optional test title and subtitle
/// - Accessibility support
///
/// Follows SOLID principles:
/// - Single Responsibility: Only handles progress visualization
/// - Open/Closed: Customizable via parameters
class TestProgressHeader extends StatelessWidget {
  /// Current question index (0-based).
  final int currentIndex;

  /// Total number of questions.
  final int totalQuestions;

  /// Optional title displayed above the progress.
  final String? title;

  /// Optional subtitle displayed below the progress.
  final String? subtitle;

  /// Whether to show the animated progress ring.
  final bool showProgressRing;

  const TestProgressHeader({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
    this.title,
    this.subtitle,
    this.showProgressRing = true,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalQuestions > 0
        ? (currentIndex + 1) / totalQuestions
        : 0.0;

    return Semantics(
      label:
          'Question ${currentIndex + 1} of $totalQuestions. '
          '${(progress * 100).toInt()}% complete.',
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.04),
          borderRadius: AppRadius.card,
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.08)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: AppTypography.titleLarge.copyWith(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                      if (subtitle != null) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          subtitle!,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (showProgressRing) ...[
                  const SizedBox(width: AppSpacing.md),
                  _buildProgressSection(progress),
                ],
              ],
            ),
            if (!showProgressRing) ...[
              const SizedBox(height: AppSpacing.md),
              _buildLinearProgress(progress),
              const SizedBox(height: AppSpacing.sm),
              _buildQuestionCounter(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(double progress) {
    return ProgressRing(
      progress: progress,
      size: 64,
      strokeWidth: 6,
      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
      progressColor: AppColors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${currentIndex + 1}',
            style: AppTypography.titleLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
          Text(
            'of $totalQuestions',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinearProgress(double progress) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.full),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            minHeight: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCounter() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Text(
        'Question ${currentIndex + 1} of $totalQuestions',
        key: ValueKey<int>(currentIndex),
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
