import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:asdsmartcare/core/ui/buttons/app_button.dart';
import 'package:asdsmartcare/core/ui/text_fields/app_text_field.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class ResetPasswordBody extends StatelessWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onReset;
  final bool isLoading;

  const ResetPasswordBody({
    super.key,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onReset,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          // Title
          const Text(
            'Create new password',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Your new password must be unique from those previously used.',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryDark.withValues(alpha: 0.7),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),

          // Inputs
          AppTextField.password(
            controller: newPasswordController,
            hint: 'New Password',
          ),
          const SizedBox(height: 20),
          AppTextField.password(
            controller: confirmPasswordController,
            hint: 'Confirm Password',
          ),
          const SizedBox(height: 48),

          // Action Button
          ConditionalBuilder(
            condition: !isLoading,
            builder: (context) => AppButton.primary(
              label: 'Reset Password',
              onPressed: onReset,
              expanded: true,
              size: AppButtonSize.large,
            ),
            fallback: (_) => const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
