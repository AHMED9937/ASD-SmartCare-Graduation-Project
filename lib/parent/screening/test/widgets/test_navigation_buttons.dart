import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

/// Navigation buttons for test screens (Next/Previous/Finish).
///
/// Features:
/// - Responsive layout (stacked on mobile, row on tablet)
/// - Loading state with spinner
/// - Animated transitions
/// - Accessibility support
///
/// Follows SOLID principles:
/// - Single Responsibility: Only handles navigation button layout
/// - Open/Closed: Callbacks are injected via parameters
class TestNavigationButtons extends StatelessWidget {
  /// Callback when next/finish button is pressed.
  final VoidCallback onNext;

  /// Callback when previous button is pressed.
  final VoidCallback? onPrevious;

  /// Whether to show the previous button.
  final bool showPrevious;

  /// Whether this is the last question.
  final bool isLastQuestion;

  /// Whether the next action is loading.
  final bool isLoading;

  /// Custom label for the next button (optional).
  final String? nextLabel;

  /// Custom label for the previous button (optional).
  final String? previousLabel;

  const TestNavigationButtons({
    super.key,
    required this.onNext,
    this.onPrevious,
    this.showPrevious = false,
    this.isLastQuestion = false,
    this.isLoading = false,
    this.nextLabel,
    this.previousLabel,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveNextLabel =
        nextLabel ?? (isLastQuestion ? 'Complete Test' : 'Next Question');
    final effectivePreviousLabel = previousLabel ?? 'Previous';

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 400;

        if (isWide && showPrevious) {
          return _buildRowLayout(effectiveNextLabel, effectivePreviousLabel);
        }
        return _buildColumnLayout(effectiveNextLabel, effectivePreviousLabel);
      },
    );
  }

  Widget _buildRowLayout(String nextLabel, String previousLabel) {
    return Row(
      children: [
        if (showPrevious) ...[
          Expanded(
            child: _buildPreviousButton(previousLabel),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
        Expanded(
          flex: showPrevious ? 2 : 1,
          child: _buildNextButton(nextLabel),
        ),
      ],
    );
  }

  Widget _buildColumnLayout(String nextLabel, String previousLabel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildNextButton(nextLabel),
        if (showPrevious) ...[
          const SizedBox(height: AppSpacing.sm),
          _buildPreviousButton(previousLabel),
        ],
      ],
    );
  }

  Widget _buildNextButton(String label) {
    return Semantics(
      button: true,
      enabled: !isLoading,
      label: isLastQuestion ? 'Complete the test' : 'Go to next question',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: isLoading
            ? Container(
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ),
              )
            : AppButton(
                label: label,
                onPressed: onNext,
                icon: isLastQuestion
                    ? Icons.check_circle_outline
                    : Icons.arrow_forward_rounded,
              ),
      ),
    );
  }

  Widget _buildPreviousButton(String label) {
    return Semantics(
      button: true,
      label: 'Go to previous question',
      child: AppButton.secondary(
        label: label,
        onPressed: onPrevious ?? () {},
        icon: Icons.arrow_back_rounded,
      ),
    );
  }
}
