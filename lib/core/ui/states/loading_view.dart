import 'package:flutter/material.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// A reusable loading view component.
///
/// Usage:
/// ```dart
/// if (state.isLoading) {
///   return const LoadingView();
/// }
/// ```
class LoadingView extends StatelessWidget {
  /// Optional loading message
  final String? message;

  /// Size of the loading indicator
  final double size;

  /// Color of the loading indicator
  final Color? color;

  /// Background color
  final Color? backgroundColor;

  const LoadingView({
    super.key,
    this.message,
    this.size = 40.0,
    this.color,
    this.backgroundColor,
  });

  /// Create a compact loading view (inline)
  const LoadingView.compact({
    super.key,
    this.message,
    this.color,
    this.backgroundColor,
  }) : size = 24.0;

  /// Create a full-screen loading overlay
  LoadingView.overlay({super.key, this.message, this.size = 40.0, this.color})
    : backgroundColor = Colors.black.withValues(alpha: 0.5);

  @override
  Widget build(BuildContext context) {
    final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: size > 30 ? 4.0 : 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? AppColors.primary,
            ),
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            message!,
            style: AppTypography.bodyMedium.copyWith(
              color: backgroundColor != null
                  ? AppColors.onPrimary
                  : AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (backgroundColor != null) {
      return Container(
        color: backgroundColor,
        child: Center(child: content),
      );
    }

    return Center(child: content);
  }
}
