import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'login_header.dart';
import 'login_form.dart';
import 'login_actions.dart';

/// The main body of the login screen.
/// Assembles subwidgets into a responsive, scrollable layout.
class LoginBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;
  final String? Function(String?) emailValidator;
  final String? Function(String?) passwordValidator;
  final VoidCallback onLoginPressed;
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onSignUpPressed;
  final bool isLoading;

  const LoginBody({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.emailValidator,
    required this.passwordValidator,
    required this.onLoginPressed,
    required this.onForgotPasswordPressed,
    required this.onSignUpPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LoginHeader(),
            LoginForm(
              formKey: formKey,
              emailController: emailController,
              passwordController: passwordController,
              rememberMe: rememberMe,
              onRememberMeChanged: onRememberMeChanged,
              emailValidator: emailValidator,
              passwordValidator: passwordValidator,
              onSubmitted: onLoginPressed,
            ),
            LoginActions(
              onLoginPressed: onLoginPressed,
              onForgotPasswordPressed: onForgotPasswordPressed,
              onSignUpPressed: onSignUpPressed,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
