import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// A card for displaying suggested actions with priority indicators.
///
/// Usage:
/// ```dart
/// ActionSuggestionCard(
///   icon: Icons.schedule,
///   title: 'Book a session',
///   subtitle: 'Schedule an appointment with a specialist',
///   priority: ActionPriority.high,
///   onTap: () => Navigator.push(...),
/// )
/// ```
class ActionSuggestionCard extends StatefulWidget {
  /// Card icon
  final IconData icon;

  /// Card title
  final String title;

  /// Card subtitle/description
  final String? subtitle;

  /// Priority level (affects color)
  final ActionPriority priority;

  /// Tap callback
  final VoidCallback? onTap;

  /// Whether to show arrow indicator
  final bool showArrow;

  const ActionSuggestionCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.priority = ActionPriority.normal,
    this.onTap,
    this.showArrow = true,
  });

  @override
  State<ActionSuggestionCard> createState() => _ActionSuggestionCardState();
}

class _ActionSuggestionCardState extends State<ActionSuggestionCard> {
  bool _isPressed = false;

  Color get _priorityColor {
    switch (widget.priority) {
      case ActionPriority.high:
        return AppColors.error;
      case ActionPriority.medium:
        return AppColors.warning;
      case ActionPriority.normal:
        return AppColors.success;
      case ActionPriority.info:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: _priorityColor.withValues(alpha: 0.08),
            borderRadius: AppRadius.card,
            border: Border.all(
              color: _priorityColor.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              _buildIconContainer(),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildContent()),
              if (widget.showArrow && widget.onTap != null)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: _priorityColor.withValues(alpha: 0.6),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: _priorityColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        widget.icon,
        color: _priorityColor,
        size: 24,
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          style: AppTypography.titleSmall.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (widget.subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            widget.subtitle!,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}

/// Priority levels for action suggestions
enum ActionPriority {
  /// High priority - red accent
  high,

  /// Medium priority - amber accent
  medium,

  /// Normal priority - green accent
  normal,

  /// Informational - blue accent
  info,
}
