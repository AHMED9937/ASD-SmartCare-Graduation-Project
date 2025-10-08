import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// A modern SliverAppBar that follows the design system.
///
/// Use this for screens with scrolling content to provide a more
/// immersive and modern feel.
class SliverAppHeader extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final double expandedHeight;
  final bool pinned;
  final bool floating;
  final Widget? leading;

  const SliverAppHeader({
    super.key,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.expandedHeight = 0,
    this.pinned = true,
    this.floating = false,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight > 0 ? expandedHeight : null,
      pinned: pinned,
      floating: floating,
      backgroundColor: AppColors.surface,
      surfaceTintColor: AppColors.surface,
      elevation: 0,
      leading: leading,
      centerTitle: false,
      title: title != null
          ? Text(
              title!,
              style: AppTypography.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
                letterSpacing: -0.5,
              ),
            )
          : null,
      actions: actions,
      flexibleSpace: flexibleSpace,
    );
  }
}
