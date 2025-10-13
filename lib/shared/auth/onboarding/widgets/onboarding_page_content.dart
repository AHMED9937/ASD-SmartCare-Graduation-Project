import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';

class OnboardingPageContent extends StatelessWidget {
  final String title;
  final String description;
  final String imageLink;

  const OnboardingPageContent({
    super.key,
    required this.title,
    required this.description,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 1. Illustration Area - Full Width
        Expanded(
          flex: 6, // Give more space to image
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Image.asset(
              imageLink,
              fit: BoxFit.contain, // Keep contain to see full illustration
              width: double.infinity,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // 2. Text Content Area
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.primaryDark.withValues(alpha: 0.7),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
