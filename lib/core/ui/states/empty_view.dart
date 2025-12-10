import 'package:flutter/material.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// A reusable empty state view component.
///
/// Usage:
/// ```dart
/// if (state.items.isEmpty) {
///   return EmptyView(
///     title: 'No appointments',
///     message: 'You don\'t have any upcoming appointments.',
///     actionText: 'Book Appointment',
///     onAction: () => navigator.pushNamed(AppRoutes.bookAppointment),
///   );
/// }
/// ```
class EmptyView extends StatelessWidget {
  /// Empty state title
  final String? title;

  /// Empty state message
  final String message;

  /// Optional action button text
  final String? actionText;

  /// Optional action callback
  final VoidCallback? onAction;

  /// Empty state icon
  final IconData icon;

  /// Optional image asset path (overrides icon)
  final String? imagePath;

  /// Icon/image size
  final double iconSize;

  const EmptyView({
    super.key,
    this.title,
    required this.message,
    this.actionText,
    this.onAction,
    this.icon = Icons.inbox_outlined,
    this.imagePath,
    this.iconSize = 80.0,
  });

  /// Create an empty view for search results
  const EmptyView.search({
    super.key,
    this.title = 'No results found',
    this.message = 'Try adjusting your search or filters.',
    this.actionText,
    this.onAction,
  }) : icon = Icons.search_off_rounded,
       imagePath = null,
       iconSize = 80.0;

  /// Create an empty view for lists
  const EmptyView.list({
    super.key,
    this.title,
    required this.message,
    this.actionText,
    this.onAction,
  }) : icon = Icons.list_alt_rounded,
       imagePath = null,
       iconSize = 80.0;

  /// Create an empty view for favorites
  const EmptyView.favorites({
    super.key,
    this.title = 'No favorites yet',
    this.message = 'Items you favorite will appear here.',
    this.actionText,
    this.onAction,
  }) : icon = Icons.favorite_border_rounded,
       imagePath = null,
       iconSize = 80.0;

  /// Create an empty view for notifications
  const EmptyView.notifications({
    super.key,
    this.title = 'No notifications',
    this.message = 'You\'re all caught up!',
    this.actionText,
    this.onAction,
  }) : icon = Icons.notifications_none_rounded,
       imagePath = null,
       iconSize = 80.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imagePath != null)
              Image.asset(imagePath!, width: iconSize, height: iconSize)
            else
              Icon(icon, size: iconSize, color: AppColors.textHint),
            if (title != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                title!,
                style: AppTypography.titleLarge.copyWith(
                  color: AppColors.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.button),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                ),
                child: Text(actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
