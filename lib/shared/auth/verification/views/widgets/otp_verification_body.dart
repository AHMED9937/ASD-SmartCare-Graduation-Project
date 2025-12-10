import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:asdsmartcare/core/ui/buttons/app_button.dart';
import 'package:asdsmartcare/core/ui/text_fields/app_otp_field.dart';
import 'package:asdsmartcare/shared/auth/login/views/auth_rich_text.dart';
import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class OtpVerificationBody extends StatelessWidget {
  final ValueChanged<String> onSubmit;
  final ValueChanged<String>? onCodeChanged;
  final VoidCallback onVerify;
  final bool isLoading;
  final String? errorMessage;

  const OtpVerificationBody({
    super.key,
    required this.onSubmit,
    this.onCodeChanged,
    required this.onVerify,
    required this.isLoading,
    this.errorMessage,
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
            'OTP Verification',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Enter the verification code we just sent on your email address.',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryDark.withValues(alpha: 0.7),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),

          // OTP Field
          Center(
            child: AppOtpField(
              onSubmit: onSubmit,
              onCodeChanged: onCodeChanged,
              numberOfFields: 4,
              hasError: errorMessage != null,
            ),
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 12),
            Center(
              child: Text(
                errorMessage!,
                style: const TextStyle(
                  color: AppColors.error,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
          const SizedBox(height: 48),

          // Verify Button
          ConditionalBuilder(
            condition: !isLoading,
            builder: (context) => AppButton.primary(
              label: 'Verify',
              onPressed: onVerify,
              expanded: true,
              size: AppButtonSize.large,
            ),
            fallback: (_) => const Center(child: CircularProgressIndicator()),
          ),
          const SizedBox(height: 32),

          // Resend Code
          const Center(
            child: MyRichtext(
              Textdis: "Didn't receive code? ",
              Textheader:
                  'Resend code', // Note: This routes to login in original, keeping logic for now
              routeName: AppRoutes.login,
            ),
          ),
        ],
      ),
    );
  }
}
