import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
import 'package:flutter/material.dart';

/// A premium, interactive back button that matches the AppHeader style.
///
/// This button features a subtle scale animation on tap and a themed background.
class AppBackButton extends StatefulWidget {
  /// Callback when button is pressed.
  final VoidCallback onPressed;

  /// Icon to display (defaults to app back icon)
  final IconData icon;

  const AppBackButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.arrow_back_ios_new_rounded,
  });

  @override
  State<AppBackButton> createState() => _AppBackButtonState();
}

class _AppBackButtonState extends State<AppBackButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(widget.icon, size: 18, color: AppColors.primary),
            ),
          );
        },
      ),
    );
  }
}
