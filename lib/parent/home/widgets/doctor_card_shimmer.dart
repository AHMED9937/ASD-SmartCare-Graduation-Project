import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';

/// Shimmer loading placeholder for doctor cards.
class DoctorCardShimmer extends StatefulWidget {
  const DoctorCardShimmer({super.key});

  @override
  State<DoctorCardShimmer> createState() => _DoctorCardShimmerState();
}

class _DoctorCardShimmerState extends State<DoctorCardShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 170,
          margin: const EdgeInsets.only(right: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildImagePlaceholder(), _buildInfoPlaceholder()],
          ),
        );
      },
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: _animation.value * 0.2),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
    );
  }

  Widget _buildInfoPlaceholder() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerBox(width: 100, height: 14),
          const SizedBox(height: 6),
          _buildShimmerBox(width: 70, height: 12, alphaMultiplier: 0.75),
          const SizedBox(height: 8),
          _buildShimmerBox(width: 40, height: 12, alphaMultiplier: 0.5),
          const SizedBox(height: 12),
          _buildShimmerBox(width: double.infinity, height: 30, borderRadius: 8),
        ],
      ),
    );
  }

  Widget _buildShimmerBox({
    required double width,
    required double height,
    double alphaMultiplier = 1.0,
    double borderRadius = 4,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(
          alpha: _animation.value * 0.15 * alphaMultiplier,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
