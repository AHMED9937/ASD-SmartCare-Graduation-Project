import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/shared/auth/password_reset/controllers/password_reset_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordstate> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);
  final PasswordFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final NewPasswordController = TextEditingController();
  final ConfirmPasswordController = TextEditingController();

  String verificationCode = '';

  Future<void> checkEmail() async {
    emit(ForgetPasswordLoading());

    try {
      await Diohelper.postData(
        url: ApiConstants.forgotPasswordEmail,
        data: {'email': emailController.text},
      ).timeout(
        const Duration(seconds: 44),
        onTimeout: () => throw Exception('Request timed out'),
      );
      emit(CheckEmailSuccess());
    } catch (e) {
      debugPrint('Email check failed: $e');
      emit(CheckEmailError(e.toString()));
    }
  }

  Future<void> checkVerificationCode() async {
    emit(ForgetPasswordLoading());

    try {
      await Diohelper.postData(
        url: ApiConstants.forgotPasswordEmailVerfiationCode,
        data: {'resetCode': verificationCode},
      ).timeout(
        const Duration(seconds: 44),
        onTimeout: () => throw Exception('Request timed out'),
      );
      emit(ResetPasswordCodeSuccess());
    } catch (e) {
      debugPrint('Verification code check failed: $e');
      emit(ResetPasswordCodeError(e.toString()));
    }
  }

  Future<void> resetPassword() async {
    emit(ForgetPasswordLoading());

    try {
      await Diohelper.postData(
        url: ApiConstants.ResetPassword,
        data: {
          'newPassword': NewPasswordController.text,
          'confirmPassword': ConfirmPasswordController.text
        },
      ).timeout(
        const Duration(seconds: 44),
        onTimeout: () => throw Exception('Request timed out'),
      );
      emit(ForgetPasswordSuccess());
    } catch (e) {
      debugPrint('Password reset failed: $e');
      emit(ForgetPasswordError(e.toString()));
    }
  }
}
