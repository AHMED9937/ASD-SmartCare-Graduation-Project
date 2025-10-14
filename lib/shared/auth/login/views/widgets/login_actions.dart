import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

/// Action section of the login screen.
/// Contains the main login button, forgot password, and sign up links.
class LoginActions extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onSignUpPressed;
  final bool isLoading;

  const LoginActions({
    super.key,
    required this.onLoginPressed,
    required this.onForgotPasswordPressed,
    required this.onSignUpPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.lg),
        // Main Login Button
        if (isLoading)
          const LoadingView.compact()
        else
          AppButton.primary(
            label: 'Log In',
            onPressed: onLoginPressed,
            expanded: true,
            size: AppButtonSize.large,
          ),
        const SizedBox(height: AppSpacing.md),
        // Forgot Password Link
        Center(
          child: TextButton(
            onPressed: onForgotPasswordPressed,
            child: Text(
              'Forgot Password?',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        // Divider with "OR" text (Visual polish)
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                'OR',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textDisabled,
                ),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        // Sign Up Link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            TextButton(
              onPressed: onSignUpPressed,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Sign Up Now',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}
