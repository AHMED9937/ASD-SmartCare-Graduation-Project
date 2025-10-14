import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:asdsmartcare/core/ui/buttons/app_button.dart';
import 'package:flutter/material.dart';

class AuthSelectionBody extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onSignupPressed;

  const AuthSelectionBody({
    super.key,
    required this.onLoginPressed,
    required this.onSignupPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1. Logo Section
          Expanded(
            flex: 4,
            child: Center(
              child: Image.asset(
                'lib/appassets/images/logo1.png',
                width: 140,
                height: 140,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 2. Welcome Text
          const Text(
            "Let's get started!",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Choose login if you already have an account\nor sign up if this is your first time.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryDark.withValues(alpha: 0.7),
              height: 1.5,
            ),
          ),

          const Spacer(flex: 1),

          // 3. Buttons
          AppButton.primary(
            label: 'Log in',
            onPressed: onLoginPressed,
            size: AppButtonSize.large,
          ),
          const SizedBox(height: 16),
          AppButton.secondary(
            label: 'Sign Up',
            onPressed: onSignupPressed,
            size: AppButtonSize.large,
          ),

          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
