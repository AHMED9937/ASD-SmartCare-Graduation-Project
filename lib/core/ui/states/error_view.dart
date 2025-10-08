import 'package:flutter/material.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// A reusable error view component.
///
/// Usage:
/// ```dart
/// if (state.hasError) {
///   return ErrorView(
///     message: state.errorMessage,
///     onRetry: () => cubit.load(),
///   );
/// }
/// ```
class ErrorView extends StatelessWidget {
  /// Error message to display
  final String message;

  /// Optional error title
  final String? title;

  /// Optional retry callback
  final VoidCallback? onRetry;

  /// Retry button text
  final String retryText;

  /// Error icon
  final IconData icon;

  /// Icon color
  final Color? iconColor;

  /// Icon size
  final double iconSize;

  const ErrorView({
    super.key,
    required this.message,
    this.title,
    this.onRetry,
    this.retryText = 'Try Again',
    this.icon = Icons.error_outline_rounded,
    this.iconColor,
    this.iconSize = 64.0,
  });

  /// Create an error view for network errors
  const ErrorView.network({
    super.key,
    this.message = 'Please check your internet connection and try again.',
    this.title = 'No Connection',
    this.onRetry,
    this.retryText = 'Try Again',
  })  : icon = Icons.wifi_off_rounded,
        iconColor = null,
        iconSize = 64.0;

  /// Create an error view for server errors
  const ErrorView.server({
    super.key,
    this.message = 'Something went wrong on our end. Please try again later.',
    this.title = 'Server Error',
    this.onRetry,
    this.retryText = 'Try Again',
  })  : icon = Icons.cloud_off_rounded,
        iconColor = null,
        iconSize = 64.0;

  /// Create a compact error view (inline)
  const ErrorView.compact({
    super.key,
    required this.message,
    this.onRetry,
    this.retryText = 'Retry',
  })  : title = null,
        icon = Icons.error_outline_rounded,
        iconColor = null,
        iconSize = 32.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor ?? AppColors.error,
            ),
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
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(retryText),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.button,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
