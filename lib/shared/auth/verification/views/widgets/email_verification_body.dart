import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:asdsmartcare/core/ui/buttons/app_button.dart';
import 'package:asdsmartcare/core/ui/text_fields/app_otp_field.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class EmailVerificationBody extends StatelessWidget {
  final ValueChanged<String> onSubmit;
  final ValueChanged<String>? onCodeChanged;
  final VoidCallback onVerify;
  final VoidCallback onResend;
  final VoidCallback onChangeEmail;
  final bool isLoading;
  final String? errorMessage;
  final String? email;

  const EmailVerificationBody({
    super.key,
    required this.onSubmit,
    this.onCodeChanged,
    required this.onVerify,
    required this.onResend,
    required this.onChangeEmail,
    required this.isLoading,
    this.errorMessage,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          // Header Text
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify Email',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Enter the code sent to your email.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Premium Email Chip
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.email_outlined,
                      color: AppColors.primary, size: 20),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      email ?? 'your email',
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    onTap: onChangeEmail,
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Change',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.edit_outlined,
                              color: AppColors.primary, size: 14),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
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
            const SizedBox(height: 16),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline,
                        color: AppColors.error, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      errorMessage!,
                      style: const TextStyle(
                        color: AppColors.error,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 48),
          // Verify Button
          ConditionalBuilder(
            condition: !isLoading,
            builder: (context) => AppButton.primary(
              label: 'Verify Account',
              onPressed: onVerify,
              expanded: true,
              size: AppButtonSize.large,
              icon: Icons.check_circle_outline,
            ),
            fallback: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          const SizedBox(height: 24),
          // Resend Link
          Center(
            child: GestureDetector(
              onTap: onResend,
              child: RichText(
                text: TextSpan(
                  text: "Didn't receive the code? ",
                  style: TextStyle(
                    color: AppColors.primaryDark.withValues(alpha: 0.6),
                    fontSize: 14,
                  ),
                  children: const [
                    TextSpan(
                      text: 'Resend',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
