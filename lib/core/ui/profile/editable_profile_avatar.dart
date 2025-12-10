import 'dart:io';
import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
import 'package:asdsmartcare/core/ui/profile/profile_avatar.dart';
import 'package:flutter/material.dart';

/// A wrapper around [ProfileAvatar] that adds an edit button and tapping logic.
class EditableProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final File? pickedImage;
  final double radius;
  final VoidCallback onTap;

  const EditableProfileAvatar({
    super.key,
    this.imageUrl,
    this.pickedImage,
    this.radius = 60.0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Reuse the premium ProfileAvatar base
          pickedImage != null
              ? _FileProfileAvatar(radius: radius, file: pickedImage!)
              : ProfileAvatar(imageUrl: imageUrl, radius: radius),
          // Floating Camera Action Button
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper internal widget to show File-based avatar with same styling as [ProfileAvatar]
class _FileProfileAvatar extends StatelessWidget {
  final double radius;
  final File file;

  const _FileProfileAvatar({required this.radius, required this.file});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: (radius + 6) * 2,
          height: (radius + 6) * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
        ),
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
          child: CircleAvatar(radius: radius, backgroundImage: FileImage(file)),
        ),
      ],
    );
  }
}
