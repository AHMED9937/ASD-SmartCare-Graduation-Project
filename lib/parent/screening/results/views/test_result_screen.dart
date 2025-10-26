import 'package:asdsmartcare/parent/navigation/parent_navigation_screen.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

/// Screen displaying test results with actionable recommendations.
///
/// Shows the test outcome with clear visual indicators and provides
/// personalized next steps based on the results.
///
/// Follows SOLID principles:
/// - Single Responsibility: Handles result display and navigation
/// - Open/Closed: Result widgets are extensible
/// - Liskov Substitution: Different result types use same interface
class Testresult extends StatelessWidget {
  /// Result from screening test (0 = negative, 1 = positive).
  final String? autismPrediction;

  /// Result from level assessment (severity level).
  final String? degreePrediction;

  const Testresult({
    super.key,
    this.autismPrediction,
    this.degreePrediction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        title: 'Your Results',
        showBackButton: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Result card
                    if (autismPrediction != null)
                      _ScreeningResultCard(prediction: autismPrediction!),
                    if (degreePrediction != null)
                      _LevelResultCard(level: degreePrediction!),

                    const SizedBox(height: AppSpacing.xl),

                    // Actions section
                    if (_showActions)
                      _SuggestedActionsSection(
                        isPositive:
                            autismPrediction == '1' || degreePrediction != null,
                      ),

                    const SizedBox(height: AppSpacing.xl),

                    // Primary CTA
                    _buildExploreDoctorsButton(context),

                    const SizedBox(height: AppSpacing.md),

                    // Secondary action
                    _buildBackToHomeButton(context),

                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _showActions => autismPrediction == '1' || degreePrediction != null;

  Widget _buildExploreDoctorsButton(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Explore recommended doctors',
      child: AppButton(
        label: 'Find Specialists Near You',
        icon: Icons.local_hospital_outlined,
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const ParentBottomNavgationScreen(),
            ),
            (_) => false,
          );
        },
      ),
    );
  }

  Widget _buildBackToHomeButton(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Return to home screen',
      child: AppButton.secondary(
        label: 'Back to Home',
        icon: Icons.home_outlined,
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const ParentBottomNavgationScreen(),
            ),
            (_) => false,
          );
        },
      ),
    );
  }
}

/// Card displaying screening test result.
class _ScreeningResultCard extends StatelessWidget {
  final String prediction;

  const _ScreeningResultCard({required this.prediction});

  bool get isPositive => prediction == '1';

  @override
  Widget build(BuildContext context) {
    return _ResultCardContainer(
      isPositive: isPositive,
      child: Column(
        children: [
          // Status icon
          _buildStatusIcon(),
          const SizedBox(height: AppSpacing.lg),

          // Badge
          isPositive
              ? const ResultBadge.negative(label: 'Signs Detected')
              : const ResultBadge.positive(label: 'No Signs Detected'),
          const SizedBox(height: AppSpacing.lg),

          // Title
          Text(
            isPositive ? 'Potential Signs Identified' : 'No Concerns Found',
            style: AppTypography.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Description
          Text(
            isPositive
                ? 'The screening suggests potential signs of autism spectrum characteristics. We recommend consulting with a healthcare professional for a comprehensive evaluation.'
                : 'Based on your responses, no significant signs of autism spectrum characteristics were detected. Continue monitoring development and consult a professional if you have concerns.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isPositive
            ? AppColors.warning.withValues(alpha: 0.15)
            : AppColors.success.withValues(alpha: 0.15),
      ),
      child: Icon(
        isPositive ? Icons.psychology_outlined : Icons.check_circle_outline,
        size: 40,
        color: isPositive ? AppColors.warning : AppColors.success,
      ),
    );
  }
}

/// Card displaying level assessment result.
class _LevelResultCard extends StatelessWidget {
  final String level;

  const _LevelResultCard({required this.level});

  @override
  Widget build(BuildContext context) {
    return _ResultCardContainer(
      isPositive: true,
      child: Column(
        children: [
          // Level indicator
          _buildLevelIndicator(),
          const SizedBox(height: AppSpacing.lg),

          // Badge
          ResultBadge.level(level: int.tryParse(level) ?? 1),
          const SizedBox(height: AppSpacing.lg),

          // Title
          Text(
            'Assessment Complete',
            style: AppTypography.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Description
          Text(
            'Your assessment indicates Level $level support needs. '
            'This information can help healthcare providers create a personalized support plan.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLevelIndicator() {
    final levelNum = int.tryParse(level) ?? 1;
    final color = _getLevelColor(levelNum);

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.15),
      ),
      child: Center(
        child: Text(
          level,
          style: AppTypography.displaySmall.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  Color _getLevelColor(int level) {
    switch (level) {
      case 1:
        return AppColors.success;
      case 2:
        return AppColors.warning;
      case 3:
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }
}

/// Container for result cards with consistent styling.
class _ResultCardContainer extends StatelessWidget {
  final Widget child;
  final bool isPositive;

  const _ResultCardContainer({
    required this.child,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Section displaying suggested actions based on results.
class _SuggestedActionsSection extends StatelessWidget {
  final bool isPositive;

  const _SuggestedActionsSection({required this.isPositive});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommended Next Steps',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        if (isPositive) ...[
          ActionSuggestionCard(
            priority: ActionPriority.high,
            icon: Icons.medical_services_outlined,
            title: 'Consult a Specialist',
            subtitle:
                'Schedule an appointment with a developmental pediatrician or child psychologist.',
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          ActionSuggestionCard(
            priority: ActionPriority.medium,
            icon: Icons.schedule_outlined,
            title: 'Early Intervention',
            subtitle: 'Research early intervention programs in your area.',
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          ActionSuggestionCard(
            priority: ActionPriority.normal,
            icon: Icons.groups_outlined,
            title: 'Join Support Groups',
            subtitle:
                'Connect with other parents for guidance and shared experiences.',
            onTap: () {},
          ),
        ] else ...[
          ActionSuggestionCard(
            priority: ActionPriority.info,
            icon: Icons.calendar_today_outlined,
            title: 'Regular Check-ups',
            subtitle: 'Continue with routine developmental screenings.',
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          ActionSuggestionCard(
            priority: ActionPriority.info,
            icon: Icons.visibility_outlined,
            title: 'Monitor Development',
            subtitle: 'Keep track of developmental milestones.',
            onTap: () {},
          ),
        ],
      ],
    );
  }
}

// Legacy widget kept for backward compatibility
class RecentTest extends StatelessWidget {
  final bool isFirstTest;
  final String prediction;
  final bool backToHomeButton;

  const RecentTest({
    super.key,
    required this.isFirstTest,
    required this.prediction,
    required this.backToHomeButton,
  });

  @override
  Widget build(BuildContext context) {
    if (isFirstTest) {
      return _ScreeningResultCard(prediction: prediction);
    } else {
      return _LevelResultCard(level: prediction);
    }
  }
}
