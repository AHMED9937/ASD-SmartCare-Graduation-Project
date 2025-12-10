import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';

/// Lightweight gradient background for the parent home screen.
/// Optimized for performance - no expensive blur filters.
class MeshGradientBackground extends StatelessWidget {
  final Widget? child;
  final bool animated; // Kept for API compatibility, but not used

  const MeshGradientBackground({super.key, this.child, this.animated = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Solid background layer to prevent transparency leaks to the system window
        const Positioned.fill(
          child: ColoredBox(color: AppColors.scaffoldBackground),
        ),

        // 2. Simple gradient background - much faster than BackdropFilter
        Container(
          decoration: BoxDecoration(gradient: AppColors.premiumGradient),
        ),

        // Content
        if (child != null) child!,
      ],
    );
  }
}
