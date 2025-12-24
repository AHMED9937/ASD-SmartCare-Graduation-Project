import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
import 'package:asdsmartcare/parent/screening/views/test_selection/widgets/test_card.dart';
import 'package:asdsmartcare/parent/screening/views/test_selection/widgets/test_selection_header.dart';

/// Body widget for the test selection screen.
///
/// Handles layout and responsiveness for the test selection content.
/// Separates presentation from the screen scaffold.
class TestSelectionBody extends StatelessWidget {
  /// Callback when autism screening test is selected
  final VoidCallback onScreeningTestTap;

  /// Callback when level assessment is selected
  final VoidCallback onLevelAssessmentTap;

  /// Optional child name for personalization
  final String? childName;

  /// Whether screening test is completed
  final bool isScreeningCompleted;

  /// Whether level assessment is completed
  final bool isLevelAssessmentCompleted;

  const TestSelectionBody({
    super.key,
    required this.onScreeningTestTap,
    required this.onLevelAssessmentTap,
    this.childName,
    this.isScreeningCompleted = false,
    this.isLevelAssessmentCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Determine if we're on a tablet-sized screen
          final isTablet = constraints.maxWidth >= 600;
          final horizontalPadding = isTablet ? AppSpacing.xxl : AppSpacing.lg;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: AppSpacing.lg,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TestSelectionHeader(childName: childName),
                    const SizedBox(height: AppSpacing.xl),
                    _buildInfoBanner(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildTestCards(isTablet),
                    const SizedBox(height: AppSpacing.xl),
                    _buildTipsSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.08),
        borderRadius: AppRadius.card,
        border: Border.all(
          color: AppColors.info.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lightbulb_outline_rounded,
              color: AppColors.info,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              'These tests use AI to analyze responses and provide insights. They are not a medical diagnosis.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.info,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestCards(bool isTablet) {
    return Column(
      children: [
        TestCard(
          icon: Icons.psychology_outlined,
          title: 'Autism Screening Test',
          description:
              'A comprehensive questionnaire to help identify potential signs of autism spectrum disorder.',
          duration: '~10 minutes',
          onTap: onScreeningTestTap,
          isCompleted: isScreeningCompleted,
          badge: _buildRecommendedBadge(),
        ),
        const SizedBox(height: AppSpacing.md),
        TestCard(
          icon: Icons.analytics_outlined,
          title: 'Autism Level Assessment',
          description:
              'Determine the severity level and get personalized recommendations based on results.',
          duration: '~15 minutes',
          onTap: onLevelAssessmentTap,
          isCompleted: isLevelAssessmentCompleted,
        ),
      ],
    );
  }

  Widget _buildRecommendedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'RECOMMENDED',
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.success,
          fontWeight: FontWeight.bold,
          fontSize: 10,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTipsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preparation Tips',
          style: AppTypography.titleMedium.copyWith(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildTipItem(
          Icons.volume_up_rounded,
          'Find a quiet environment free from distractions',
        ),
        _buildTipItem(
          Icons.timer_rounded,
          'Set aside enough time to complete without rushing',
        ),
        _buildTipItem(
          Icons.edit_note_rounded,
          'Have your child nearby to observe behaviors if needed',
        ),
      ],
    );
  }

  Widget _buildTipItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
