import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
import 'package:flutter/material.dart';

/// A premium profile avatar with a dual-ring border design.
class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final Color? borderColor;
  final IconData placeholderIcon;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.radius = 48.0,
    this.borderColor,
    this.placeholderIcon = Icons.person,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = borderColor ?? AppColors.primary;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer decorative ring
        Container(
          width: (radius + 6) * 2,
          height: (radius + 6) * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: effectiveBorderColor.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
        ),
        // Inner border and avatar
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.disabled,
            backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                ? NetworkImage(imageUrl!)
                : null,
            child: imageUrl == null || imageUrl!.isEmpty
                ? Icon(
                    placeholderIcon,
                    size: radius,
                    color: AppColors.textSecondary,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
