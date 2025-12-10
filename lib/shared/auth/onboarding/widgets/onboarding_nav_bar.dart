import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingNavBar extends StatelessWidget {
  final PageController pageController;
  final int pageCount;
  final bool isLastPage;
  final VoidCallback onNext;

  const OnboardingNavBar({
    super.key,
    required this.pageController,
    required this.pageCount,
    required this.isLastPage,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Indicator
          SmoothPageIndicator(
            controller: pageController,
            count: pageCount,
            effect: const WormEffect(
              dotWidth: 10,
              dotHeight: 10,
              spacing: 8,
              activeDotColor: AppColors.primary,
              dotColor: Color(0xFFE0E0E0),
            ),
          ),

          // Next / Get Started Button
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              isLastPage ? 'Get Started' : 'Next',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
