import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/views/booking_screen.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/models/doctor_model.dart';

/// A premium, delightful Doctor Card design.
class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      borderRadius: AppRadius.lgRadius,
      elevation: 0,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Reservationscreen(myDoctor: doctor),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(theme),
                const SizedBox(height: AppSpacing.xxs),
                _buildSpecialty(theme),
                const SizedBox(height: AppSpacing.xs),
                _buildRating(theme),
                const SizedBox(height: AppSpacing.sm),
                _buildFooter(theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Hero(
      tag: 'doctor_avatar_${doctor.id}',
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: AppRadius.mdRadius,
          color: AppColors.primary.withValues(alpha: 0.05),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: doctor.image != null
            ? Image.network(
                doctor.image!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (_, __, ___) => _buildPlaceholder(),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              )
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return const Center(
      child: Icon(
        Icons.person_rounded,
        color: AppColors.primary,
        size: 40,
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            doctor.parent?.userName ?? 'Specialist',
            style: AppTypography.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onBackground,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Icon(
          Icons.verified_rounded,
          color: AppColors.primary.withValues(alpha: 0.8),
          size: 18,
        ),
      ],
    );
  }

  Widget _buildSpecialty(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLighter.withValues(alpha: 0.4),
        borderRadius: AppRadius.xsRadius,
      ),
      child: Text(
        doctor.speciailization ?? 'General Therapist',
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.primaryDark,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRating(ThemeData theme) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: (doctor.ratingsAverage ?? 0).toDouble(),
          itemBuilder: (context, index) => const Icon(
            Icons.star_rounded,
            color: AppColors.warning,
          ),
          itemCount: 5,
          itemSize: 16.0,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '${doctor.ratingsAverage ?? 0} (${doctor.ratingQuantity} reviews)',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${doctor.sessionPrice} EGP',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              TextSpan(
                text: ' / session',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xxs,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: AppRadius.smRadius,
          ),
          child: const Text(
            'Book',
            style: TextStyle(
              color: AppColors.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
