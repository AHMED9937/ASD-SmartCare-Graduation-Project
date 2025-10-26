import 'package:asdsmartcare/parent/screening/results/views/test_result_screen.dart';
import 'package:asdsmartcare/parent/screening/test/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/autism_test_cubit.dart';
import '../controllers/autism_test_state.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

/// Screen for conducting the autism screening test.
///
/// Displays questions one at a time with progress tracking and
/// smooth animations between questions.
///
/// Follows SOLID principles:
/// - Single Responsibility: Handles screen scaffold and BLoC connection
/// - Open/Closed: Uses injected widgets for question display
/// - Dependency Inversion: Depends on cubit abstraction
class AutismTestScreen extends StatelessWidget {
  const AutismTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AutismTestCubit(),
      child: const _AutismTestView(),
    );
  }
}

class _AutismTestView extends StatelessWidget {
  const _AutismTestView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AutismTestCubit, AutismTestStates>(
      listener: _handleStateChanges,
      builder: (context, state) {
        final cubit = AutismTestCubit.get(context);
        final pages = cubit.buildQuestionWidgets();
        final idx = cubit.currentIndex;
        final total = pages.length;
        final isLoading = state is GetQsFinalPredictionLoadingState;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) _showExitConfirmation(context);
          },
          child: Scaffold(
            appBar: const AppHeader(
              showBackButton: true,
            ),
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - AppSpacing.lg * 2,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Progress header with animated ring
                          TestProgressHeader(
                            currentIndex: idx,
                            totalQuestions: total,
                            title: 'Autism Screening',
                            subtitle: 'Answer honestly for accurate results',
                          ),
                          const SizedBox(height: AppSpacing.lg),

                          // Question card with animation
                          QuestionCard(
                            animationKey: idx,
                            minHeight: 320,
                            child: pages[idx],
                          ),
                          const SizedBox(height: AppSpacing.xl),

                          // Navigation buttons
                          TestNavigationButtons(
                            onNext: () => cubit.reasonFinalPredictionForQs(),
                            onPrevious: () => cubit.prev(),
                            showPrevious: idx > 0,
                            isLastQuestion: idx >= total - 1,
                            isLoading: isLoading,
                          ),
                          const SizedBox(height: AppSpacing.lg),

                          // Exit test link
                          _buildExitLink(context),
                          const SizedBox(height: AppSpacing.md),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleStateChanges(BuildContext context, AutismTestStates state) {
    final cubit = AutismTestCubit.get(context);

    if (state is GetOneQsPredictionSuccessState) {
      cubit.next();
    }

    if (state is GetQsFinalPredictionSuccessState) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => Testresult(
            autismPrediction: state.prediction.toString(),
          ),
        ),
        (_) => false,
      );
    }

    if (state is GetQsFinalPredictionErrorState) {
      _showErrorSnackBar(context,
          state.err ?? 'The answer is not relevant. Please try again.');
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.error,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                message,
                style: AppTypography.bodyMedium.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  Future<void> _showExitConfirmation(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        title: Text(
          'Exit Test?',
          style: AppTypography.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Your progress will be lost if you exit now. Are you sure you want to leave?',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Continue Test',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Exit',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );

    if ((shouldExit ?? false) && context.mounted) {
      Navigator.pop(context);
    }
  }

  Widget _buildExitLink(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Exit test and discard progress',
      child: TextButton.icon(
        onPressed: () => _showExitConfirmation(context),
        icon: const Icon(
          Icons.close,
          size: 18,
          color: AppColors.textSecondary,
        ),
        label: Text(
          'Exit Test',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
