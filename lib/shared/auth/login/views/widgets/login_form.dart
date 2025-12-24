import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

/// Form section of the login screen.
/// Encapsulates email, password fields and the remember me toggle.
class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;
  final String? Function(String?) emailValidator;
  final String? Function(String?) passwordValidator;
  final VoidCallback onSubmitted;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.emailValidator,
    required this.passwordValidator,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email field using core component
          AppTextField.email(
            controller: emailController,
            validator: emailValidator,
            label: 'Email Address',
            hint: 'Enter your email',
          ),
          const SizedBox(height: AppSpacing.lg),
          // Password field using core component
          AppTextField.password(
            controller: passwordController,
            validator: passwordValidator,
            label: 'Password',
            hint: 'Enter your password',
            onFieldSubmitted: (_) => onSubmitted(),
          ),
          const SizedBox(height: AppSpacing.sm),
          // Remember Me Row
          Theme(
            data: Theme.of(context).copyWith(
              checkboxTheme: CheckboxThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
              ),
            ),
            child: CheckboxListTile(
              value: rememberMe,
              onChanged: onRememberMeChanged,
              title: Text(
                'Remember Me',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              activeColor: AppColors.primary,
              dense: true,
            ),
          ),
        ],
      ),
    );
  }
}
