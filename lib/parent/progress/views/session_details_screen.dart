import 'package:asdsmartcare/parent/progress/views/doctor_review_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asdsmartcare/parent/progress/controllers/session_review_cubit.dart';
import 'package:asdsmartcare/parent/progress/controllers/session_review_state.dart';
import 'package:asdsmartcare/parent/progress/models/session_model.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

/// Show rating dialogs
void showRatingDialog(BuildContext outerContext, SessionData session) {
  final cubit = SessionReviewCubit.get(outerContext);
  showDialog(
    context: outerContext,
    barrierDismissible: true,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: _RatingDialog(session: session),
    ),
  );
}

class SessionDetail extends StatelessWidget {
  final SessionData session;
  const SessionDetail({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionReviewCubit(),
      child: Scaffold(
        appBar: const AppHeader(
          title: '', // Title moved to PageHeader for modern look
        ),
        body: SessionDetailBody(session: session),
        bottomNavigationBar: _ActionButtons(session: session),
      ),
    );
  }
}

class SessionDetailBody extends StatelessWidget {
  final SessionData session;
  const SessionDetailBody({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final comments = session.comments ?? [];

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        PageHeader(
          title: 'Session Details',
          subtitle: 'Reviewing session #${session.sessionNumber}',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: _SessionInfoCard(session: session),
        ),
        if (comments.isNotEmpty) ...[
          const SectionHeader(
            title: 'Doctor\'s Notes',
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
          ),
          ...comments.map(
            (comment) =>
                _CommentCard(comment: comment, date: session.sessionDate ?? ''),
          ),
        ] else
          const Padding(
            padding: EdgeInsets.all(AppSpacing.xl),
            child: EmptyView(message: 'No notes available for this session.'),
          ),
      ],
    );
  }
}

class _SessionInfoCard extends StatelessWidget {
  final SessionData session;
  const _SessionInfoCard({required this.session});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.primary.withValues(alpha: 0.05),
      hasShadow: false,
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_today_rounded,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Session Date',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  session.sessionDate ?? 'N/A',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Number',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '#${session.sessionNumber}',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommentCard extends StatelessWidget {
  final String comment;
  final String date;

  const _CommentCard({required this.comment, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: const Icon(
                Icons.person_outline,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Doctor\'s Feedback',
                        style: AppTypography.labelMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      Text(
                        date,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    comment,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.onSurface,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final SessionData session;
  const _ActionButtons({required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: AppButton.secondary(
                label: 'Rate Doctor',
                onPressed: () => DoctorReviewDialog.show(context, session),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppButton(
                label: 'Rate Session',
                onPressed: () => showRatingDialog(context, session),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Session‐rating dialog
class _RatingDialog extends StatelessWidget {
  final SessionData session;
  const _RatingDialog({required this.session});

  @override
  Widget build(BuildContext context) {
    final cubit = SessionReviewCubit.get(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: AppCard(
        padding: EdgeInsets.zero,
        child: BlocConsumer<SessionReviewCubit, SessionReviewState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SessionReviewStateLoaded) {
              return _buildSuccessContent(
                context,
                'Your rating has been submitted successfully.',
              );
            }
            if (state is SessionReviewStateError) {
              return _buildErrorContent(context, () {
                cubit.submitSessionReview(session.sId ?? '');
              });
            }
            return _buildFormContent(
              cubit,
              () => cubit.submitSessionReview(session.sId ?? ''),
              title: 'Rate this session',
              buttonText: 'Submit Rating',
            );
          },
        ),
      ),
    );
  }
}

// Shared widgets

Widget _buildSuccessContent(BuildContext context, String message) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.xl),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle_outline,
            color: AppColors.success,
            size: 48,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Thank you!',
          style: AppTypography.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        SizedBox(
          width: double.infinity,
          child: AppButton(
            label: 'Close',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildErrorContent(BuildContext context, VoidCallback onRetry) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.xl),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.error_outline,
            color: AppColors.error,
            size: 48,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Submission Failed',
          style: AppTypography.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.error,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Something went wrong. Please try again.',
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        SizedBox(
          width: double.infinity,
          child: AppButton(label: 'Retry', onPressed: onRetry),
        ),
      ],
    ),
  );
}

Widget _buildFormContent(
  SessionReviewCubit cubit,
  VoidCallback onSubmit, {
  String title = 'Rate this session',
  String buttonText = 'Rate',
}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(AppSpacing.xl),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTypography.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'How was your experience with this session?',
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (i) {
            final isSelected = i < cubit.rating;
            return IconButton(
              iconSize: 40,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              icon: Icon(
                isSelected ? Icons.star_rounded : Icons.star_outline_rounded,
                color: isSelected ? Colors.amber : AppColors.border,
              ),
              onPressed: () => cubit.updateRating(i + 1),
            );
          }),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: cubit.controller,
          maxLines: 3,
          style: AppTypography.bodyMedium,
          decoration: InputDecoration(
            hintText: 'Any comments (optional)',
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
            filled: true,
            fillColor: AppColors.primaryLighter.withValues(alpha: 0.3),
            border: OutlineInputBorder(
              borderRadius: AppRadius.mdRadius,
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(AppSpacing.md),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        ConditionalBuilder(
          condition: cubit.state is! SessionReviewStateLoading,
          builder: (_) => AppButton(label: buttonText, onPressed: onSubmit),
          fallback: (_) => const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    ),
  );
}
