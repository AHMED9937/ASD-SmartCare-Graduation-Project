import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/find_doctors/details/controllers/session_reviews_cubit.dart';
import 'package:asdsmartcare/parent/find_doctors/details/controllers/session_reviews_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Example widget displaying session reviews in a ListView.builder
class ReviewListView extends StatelessWidget {
  final String ID;
  final bool showAllReviews;

  const ReviewListView(
      {super.key, required this.ID, required this.showAllReviews});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = SessionReviewsListCubit();
        if (showAllReviews) {
          cubit.getDoctorSessionsReviewsList(ID);
        } else {
          cubit.getSessionReviewsList(ID);
        }
        return cubit;
      },
      child: BlocConsumer<SessionReviewsListCubit, GetSessionReviewsListStates>(
        listener: (_, __) {},
        builder: (context, state) {
          if (state is GetSessionReviewsListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is GetSessionReviewsListSuccessState) {
            final reviews = state.reviews;
            if (reviews!.isEmpty) {
              return Center(
                child: Text(
                  'No reviews yet.',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.xxs,
                    horizontal: AppSpacing.sm,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryLighter,
                      borderRadius: AppRadius.smRadius,
                    ),
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 14,
                              backgroundColor: AppColors.disabled,
                              child: Icon(Icons.person,
                                  size: 14, color: AppColors.surface),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(
                                review.parent?.userName ?? 'Anonymous',
                                style: AppTypography.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  i < (review.ratings ?? 0)
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 14,
                                  color: AppColors.warning,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if ((review.title ?? '').isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            review.title!,
                            style: AppTypography.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          }

          // fallback for error or other states
          return Center(
            child: Text(
              'Error loading reviews',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.error,
              ),
            ),
          );
        },
      ),
    );
  }
}
