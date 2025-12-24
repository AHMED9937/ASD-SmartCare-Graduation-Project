import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/auth/password_reset/controllers/password_reset_cubit.dart';
import 'package:asdsmartcare/shared/auth/password_reset/controllers/password_reset_state.dart';
import 'package:asdsmartcare/shared/auth/password_reset/widgets/forgot_password_body.dart';
import 'package:asdsmartcare/shared/auth/verification/views/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Forgetpasswordscreen extends StatelessWidget {
  const Forgetpasswordscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.transparent(),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ForgetPasswordCubit(),
          child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordstate>(
            listener: (context, state) {
              if (state is CheckEmailSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green,
                    content: const Text('Success'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Otpverificationscreen(),
                    ));
              }
              if (state is CheckEmailError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                    content: const Text('Error: Please check your email'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              }
            },
            builder: (context, state) {
              final cubit = ForgetPasswordCubit.get(context);
              return ForgotPasswordBody(
                formKey: cubit.PasswordFormKey,
                emailController: cubit.emailController,
                isLoading: state is ForgetPasswordLoading,
                onSendCode: () {
                  cubit.CheckEmail();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
