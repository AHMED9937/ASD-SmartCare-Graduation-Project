import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

/// Shows a rating dialog for doctor reviews.
///
/// Displays a star selector, optional comment field, and submit button.
///
/// Usage:
/// ```dart
/// await showDoctorRatingDialog(context);
/// ```
Future<void> showDoctorRatingDialog(BuildContext context) async {
  int rating = 0;
  final TextEditingController commentController = TextEditingController();

  await showDialog(
    context: context,
    builder: (ctx) {
      return Dialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.dialog,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Rate this session',
                    style: AppTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final filled = index < rating;
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          color: filled
                              ? AppColors.warning
                              : AppColors.textDisabled,
                          size: 35,
                        ),
                        onPressed: () => setState(() {
                          rating = index + 1;
                        }),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Why you recommend this doctor (Optional)',
                      hintStyle: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textHint,
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: AppRadius.mdRadius,
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(
                    label: 'Rate Now',
                    onPressed: () {
                      // Submit rating to backend, then close dialog
                      // Rating: $rating, Comment: ${commentController.text}
                      debugPrint(
                          'Rating submitted: $rating stars, comment: ${commentController.text}');
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
