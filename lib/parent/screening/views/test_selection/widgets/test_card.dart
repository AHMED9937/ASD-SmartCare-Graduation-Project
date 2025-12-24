import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
import 'package:flutter/material.dart';

/// A card widget for displaying a test option with icon, description, and duration.
///
/// Features:
/// - Animated press feedback
/// - Semantic colors from design system
/// - Responsive layout
/// - Accessibility support
class TestCard extends StatefulWidget {
  /// Icon to display
  final IconData icon;

  /// Card title
  final String title;

  /// Card description
  final String description;

  /// Estimated duration text
  final String duration;

  /// Tap callback
  final VoidCallback onTap;

  /// Optional badge widget (e.g., "Recommended")
  final Widget? badge;

  /// Whether the test is completed
  final bool isCompleted;

  const TestCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.duration,
    required this.onTap,
    this.badge,
    this.isCompleted = false,
  });

  @override
  State<TestCard> createState() => _TestCardState();
}

class _TestCardState extends State<TestCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label:
          '${widget.title}. ${widget.description}. Duration: ${widget.duration}',
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.98 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.card,
              border: Border.all(
                color: widget.isCompleted
                    ? AppColors.success.withValues(alpha: 0.3)
                    : AppColors.primary.withValues(alpha: 0.15),
                width: widget.isCompleted ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildIcon(),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: _buildContent()),
                _buildTrailing(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.15),
            AppColors.primary.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        widget.icon,
        size: 28,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.badge != null) ...[
          widget.badge!,
          const SizedBox(height: AppSpacing.xs),
        ],
        Text(
          widget.title,
          style: AppTypography.titleMedium.copyWith(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          widget.description,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
            height: 1.4,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildDurationChip(),
      ],
    );
  }

  Widget _buildDurationChip() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.schedule_rounded,
            size: 14,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            widget.duration,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailing() {
    if (widget.isCompleted) {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_rounded,
          size: 18,
          color: AppColors.success,
        ),
      );
    }
    return Icon(
      Icons.arrow_forward_ios_rounded,
      size: 16,
      color: AppColors.primary.withValues(alpha: 0.5),
    );
  }
}
