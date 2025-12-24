import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/auth/password_reset/controllers/password_reset_cubit.dart';
import 'package:asdsmartcare/shared/auth/password_reset/controllers/password_reset_state.dart';
import 'package:asdsmartcare/shared/auth/password_reset/views/new_password_screen.dart';
import 'package:asdsmartcare/shared/auth/verification/views/widgets/otp_verification_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Otpverificationscreen extends StatefulWidget {
  const Otpverificationscreen({super.key});
  @override
  _OtpverificationscreenState createState() => _OtpverificationscreenState();
}

class _OtpverificationscreenState extends State<Otpverificationscreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordstate>(
        listener: (context, state) {
          if (state is ResetPasswordCodeSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CreatenewpasswordScreen(),
              ),
            );
          } else if (state is ForgetPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error: Invalid Code')),
            );
          }
        },
        builder: (context, state) {
          final cubit = ForgetPasswordCubit.get(context);
          return Scaffold(
            appBar: const AppHeader.transparent(),
            body: SafeArea(
              child: OtpVerificationBody(
                isLoading: state is ForgetPasswordLoading,
                // Sanitize error message for better UX
                errorMessage: (state is ForgetPasswordError)
                    ? 'Something went wrong. Please try again.'
                    : (state is ResetPasswordCodeError
                        ? 'Invalid verification code. Please check and try again.'
                        : null),
                onSubmit: (code) {
                  cubit.VerficationCode = code;
                  // Optional: Auto-verify on submit? The original code had a button.
                  // We will keep the button logic in standard flow,
                  // but user might want auto-submit. For now, just set code.
                },
                onCodeChanged: (code) {
                  cubit.VerficationCode = code;
                },
                onVerify: () {
                  cubit.CheckVerficationCode();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
