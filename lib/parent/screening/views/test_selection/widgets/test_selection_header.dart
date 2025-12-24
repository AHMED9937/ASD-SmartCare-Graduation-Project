import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

/// Header widget for the test selection screen.
///
/// Displays a welcome message and instructions for the user.
/// Uses design system tokens for consistent styling.
class TestSelectionHeader extends StatelessWidget {
  /// Optional child name for personalization
  final String? childName;

  const TestSelectionHeader({
    super.key,
    this.childName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Greeting with optional personalization
        Text(
          childName != null ? 'Hello, $childName\'s Parent!' : 'Welcome!',
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        // Main heading using PageHeader style but without extra padding
        Text(
          'AI Screening',
          style: AppTypography.headlineMedium.copyWith(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // Description
        Text(
          'Select an assessment to begin evaluating your child with our advanced AI technology.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
