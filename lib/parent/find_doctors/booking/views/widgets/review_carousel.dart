import 'dart:async';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/find_doctors/details/controllers/session_reviews_cubit.dart';
import 'package:asdsmartcare/parent/find_doctors/details/controllers/session_reviews_state.dart';
import 'package:asdsmartcare/parent/find_doctors/details/models/session_review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A premium, auto-scrolling horizontal carousel for patient reviews.
class ReviewCarousel extends StatefulWidget {
  final String doctorId;

  const ReviewCarousel({super.key, required this.doctorId});

  @override
  State<ReviewCarousel> createState() => _ReviewCarouselState();
}

class _ReviewCarouselState extends State<ReviewCarousel> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll(int count) {
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % count;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionReviewsListCubit()
        ..getDoctorSessionsReviewsList(widget.doctorId),
      child: BlocBuilder<SessionReviewsListCubit, GetSessionReviewsListStates>(
        builder: (context, state) {
          if (state is GetSessionReviewsListLoadingState) {
            return const SizedBox(
              height: 160,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          }

          if (state is GetSessionReviewsListSuccessState) {
            final reviews = state.reviews ?? [];
            if (reviews.isEmpty) return const SizedBox.shrink();

            _startAutoScroll(reviews.length);

            return SizedBox(
              height: 180,
              child: PageView.builder(
                controller: _pageController,
                itemCount: reviews.length,
                onPageChanged: (index) => _currentPage = index,
                itemBuilder: (context, index) {
                  return ReviewCard(
                    review: reviews[index],
                    onTap: () => _showReviewDetail(context, reviews[index]),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showReviewDetail(BuildContext context, SessionReview review) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ReviewDetailSheet(review: review),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final SessionReview review;
  final VoidCallback onTap;

  const ReviewCard({super.key, required this.review, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surface,
              AppColors.primary.withValues(alpha: 0.04),
            ],
          ),
          borderRadius: AppRadius.lgRadius,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.12),
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10,
              top: -10,
              child: Icon(
                Icons.format_quote_rounded,
                size: 80,
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            width: 2,
                          ),
                        ),
                        child: const ProfileAvatar(radius: 22),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.parent?.userName ?? 'Verified Patient',
                              style: AppTypography.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDark,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (i) => Icon(
                                    i < (review.ratings ?? 0)
                                        ? Icons.star_rounded
                                        : Icons.star_outline_rounded,
                                    size: 14,
                                    color: AppColors.warning,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${review.ratings}.0',
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const AppSpacer.md(),
                  Expanded(
                    child: Text(
                      review.title ?? 'No comment provided.',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.onBackground.withValues(alpha: 0.7),
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'View Story',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: AppColors.primary,
                      ),
                    ],
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

class ReviewDetailSheet extends StatelessWidget {
  final SessionReview review;

  const ReviewDetailSheet({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        MediaQuery.of(context).padding.bottom + AppSpacing.xl,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.disabled.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const AppSpacer.xl(),
          Row(
            children: [
              const ProfileAvatar(radius: 28),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.parent?.userName ?? 'Anonymous Patient',
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const AppSpacer.xxs(),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(
                              i < (review.ratings ?? 0)
                                  ? Icons.star_rounded
                                  : Icons.star_outline_rounded,
                              size: 18,
                              color: AppColors.warning,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          '${review.ratings}.0',
                          style: AppTypography.labelMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const AppSpacer.xl(),
          const SectionHeader(title: 'Patient Experience'),
          const AppSpacer.sm(),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.04),
              borderRadius: AppRadius.mdRadius,
              border:
                  Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
            ),
            child: Text(
              review.title ??
                  'The patient did not leave a written comment but gave a rating of ${review.ratings} stars.',
              style: AppTypography.bodyLarge.copyWith(
                height: 1.6,
                color: AppColors.onBackground.withValues(alpha: 0.8),
              ),
            ),
          ),
          const AppSpacer.xxl(),
          AppButton.secondary(
            label: 'Close',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
