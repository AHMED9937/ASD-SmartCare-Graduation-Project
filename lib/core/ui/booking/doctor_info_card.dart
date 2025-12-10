import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// A reusable doctor info card used in booking flows.
///
/// Usage:
/// ```dart
/// DoctorInfoCard(
///   name: 'Dr. John Smith',
///   specialty: 'Neuropsychologist',
///   imageUrl: 'https://...',
///   rating: 4.5,
/// )
/// ```
class DoctorInfoCard extends StatelessWidget {
  /// Doctor's display name
  final String name;

  /// Doctor's specialty/specialization
  final String? specialty;

  /// Doctor's profile image URL
  final String? imageUrl;

  /// Doctor's average rating (0-5)
  final double? rating;

  /// Optional hero tag for avatar animation
  final String? heroTag;

  /// Whether to use compact layout (smaller avatar, single line)
  final bool compact;

  /// Optional trailing widget (e.g., chat button)
  final Widget? trailing;

  const DoctorInfoCard({
    super.key,
    required this.name,
    this.specialty,
    this.imageUrl,
    this.rating,
    this.heroTag,
    this.compact = false,
    this.trailing,
  });

  /// Creates a compact variant for smaller spaces
  const DoctorInfoCard.compact({
    super.key,
    required this.name,
    this.specialty,
    this.imageUrl,
    this.rating,
    this.heroTag,
    this.trailing,
  }) : compact = true;

  @override
  Widget build(BuildContext context) {
    final avatarRadius = compact ? 36.0 : 48.0;

    return Row(
      children: [
        _buildAvatar(avatarRadius),
        SizedBox(width: compact ? AppSpacing.md : AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style:
                    (compact
                            ? AppTypography.titleMedium
                            : AppTypography.titleLarge)
                        .copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.onPrimary,
                        ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (specialty != null) ...[
                SizedBox(height: compact ? AppSpacing.xxs : AppSpacing.xs),
                Text(
                  specialty!,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.onPrimary.withValues(alpha: 0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (rating != null) ...[
                SizedBox(height: compact ? AppSpacing.xs : AppSpacing.sm),
                RatingBarIndicator(
                  rating: rating!,
                  itemBuilder: (context, index) =>
                      const Icon(Icons.star_rounded, color: AppColors.warning),
                  itemCount: 5,
                  itemSize: compact ? 14.0 : 18.0,
                  unratedColor: AppColors.onPrimary.withValues(alpha: 0.3),
                ),
              ],
              if (trailing != null) ...[
                const SizedBox(height: AppSpacing.sm),
                trailing!,
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(double radius) {
    final avatar = Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildPlaceholder(radius),
            )
          : _buildPlaceholder(radius),
    );

    if (heroTag != null) {
      return Hero(tag: heroTag!, child: avatar);
    }
    return avatar;
  }

  Widget _buildPlaceholder(double radius) {
    return Center(
      child: Icon(
        Icons.person_rounded,
        size: radius,
        color: AppColors.textSecondary,
      ),
    );
  }
}
