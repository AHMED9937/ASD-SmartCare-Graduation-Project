import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
import 'package:asdsmartcare/core/ui/buttons/app_back_button.dart';

/// Modern, elegant app header that blends with the screen background.
///
/// Features:
/// - Screen-consistent background integration
/// - Simplified, clean back button navigation
/// - Premium typography using design system tokens
///
/// Usage:
/// ```dart
/// Scaffold(
///   appBar: AppHeader(
///     title: 'Home',
///     actions: [
///       IconButton(icon: Icon(Icons.settings), onPressed: () {}),
///     ],
///   ),
///   body: ...
/// )
/// ```
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  /// Title text
  final String? title;

  /// Title widget (overrides title text)
  final Widget? titleWidget;

  /// Leading widget (overrides default back button)
  final Widget? leading;

  /// Whether to show back button automatically
  final bool automaticallyImplyLeading;

  /// Action buttons
  final List<Widget>? actions;

  /// Background color
  final Color? backgroundColor;

  /// Foreground color (icons, text)
  final Color? foregroundColor;

  /// Elevation
  final double? elevation;

  /// Whether title is centered
  final bool centerTitle;

  /// Bottom widget (e.g., TabBar)
  final PreferredSizeWidget? bottom;

  /// Explicitly show or hide back button (overrides automaticallyImplyLeading)
  /// Set to false for bottom navigation pages
  final bool? showBackButton;

  const AppHeader({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.centerTitle = false,
    this.bottom,
    this.showBackButton,
  });

  /// Create a transparent header (for overlaying on images)
  const AppHeader.transparent({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.foregroundColor = AppColors.onSurface,
    this.centerTitle = false,
    this.bottom,
    this.showBackButton,
  }) : backgroundColor = AppColors.transparent,
       elevation = 0;

  /// Create a header with search functionality
  factory AppHeader.search({
    Key? key,
    required String hint,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onBack,
    TextEditingController? controller,
    List<Widget>? actions,
  }) {
    return AppHeader(
      key: key,
      titleWidget: _SearchAppBarTitle(
        hint: hint,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        controller: controller,
      ),
      leading: onBack != null ? AppBackButton(onPressed: onBack) : null,
      actions: actions,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(64 + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    final shouldShowBackButton =
        showBackButton ??
        (automaticallyImplyLeading && canPop && leading == null);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.transparent,
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 64,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Leading / Back Button
                    if (leading != null)
                      leading!
                    else if (shouldShowBackButton)
                      AppBackButton(
                        onPressed: () {
                          // Safety check: only pop if we can actually pop
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          }
                        },
                      )
                    else
                      const SizedBox.shrink(),

                    if (shouldShowBackButton || leading != null)
                      if (!centerTitle) const SizedBox(width: AppSpacing.md),

                    // Title
                    Expanded(
                      child: centerTitle
                          ? Center(child: _buildTitle())
                          : _buildTitle(),
                    ),

                    if (!centerTitle) const SizedBox(width: AppSpacing.md),

                    // Actions
                    if (actions != null && actions!.isNotEmpty)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actions!
                            .map((action) => _wrapAction(action))
                            .toList(),
                      )
                    else if (centerTitle)
                      const SizedBox(width: 48)
                    else
                      const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
            if (bottom != null) bottom!,
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    if (titleWidget != null) return titleWidget!;
    if (title == null) return const SizedBox.shrink();

    return Text(
      title!,
      style: AppTypography.titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.primaryDark,
        letterSpacing: -0.2,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _wrapAction(Widget action) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: action,
    );
  }
}

/// Search title widget for AppHeader.search
class _SearchAppBarTitle extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;

  const _SearchAppBarTitle({
    required this.hint,
    this.onChanged,
    this.onSubmitted,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            size: 20,
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              autofocus: true,
              textInputAction: TextInputAction.search,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.primaryDark,
              ),
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: AppColors.primaryDark.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
