import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/auth/password_reset/controllers/password_reset_cubit.dart';
import 'package:asdsmartcare/shared/auth/password_reset/controllers/password_reset_state.dart';
import 'package:asdsmartcare/shared/auth/password_reset/views/password_changed_screen.dart';
import 'package:asdsmartcare/shared/auth/password_reset/views/widgets/reset_password_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatenewpasswordScreen extends StatelessWidget {
  const CreatenewpasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordstate>(
        listener: (context, state) {
          if (state is ForgetPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.error,
              ),
            );
          }
          if (state is ForgetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.success,
                content: Text('Password Reset Successfully!'),
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Passwordchangedscreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          final cubit = ForgetPasswordCubit.get(context);
          return Scaffold(
            appBar: const AppHeader.transparent(),
            body: SafeArea(
              child: ResetPasswordBody(
                newPasswordController: cubit.NewPasswordController,
                confirmPasswordController: cubit.ConfirmPasswordController,
                isLoading: state is ForgetPasswordLoading,
                onReset: () {
                  cubit.ResetPasswordCall();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
