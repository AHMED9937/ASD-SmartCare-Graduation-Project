import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:asdsmartcare/core/ui/buttons/app_button.dart';
import 'package:asdsmartcare/core/ui/text_fields/app_text_field.dart';
import 'package:asdsmartcare/shared/auth/login/views/auth_rich_text.dart';
import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class ForgotPasswordBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final VoidCallback onSendCode;
  final bool isLoading;

  const ForgotPasswordBody({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.onSendCode,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. Title Section
            const SizedBox(height: 24),
            const Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Don't worry! It happens. Please enter the email address linked with your account.",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryDark.withValues(alpha: 0.7),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 48),

            // 3. Email Input
            AppTextField(
              controller: emailController,
              hint: 'Enter your email',
              prefixIcon: Icons.email_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),

            const SizedBox(height: 48),

            // 4. Send Button
            ConditionalBuilder(
              condition: !isLoading,
              builder: (context) => AppButton.primary(
                label: 'Send Code',
                onPressed: onSendCode,
                expanded: true,
                size: AppButtonSize.large,
              ),
              fallback: (_) => const Center(child: CircularProgressIndicator()),
            ),

            const SizedBox(height: 32),

            // 5. Back to Login
            const Center(
              child: MyRichtext(
                Textdis: 'Remember password? ',
                Textheader: 'Log in',
                routeName: AppRoutes.login,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
