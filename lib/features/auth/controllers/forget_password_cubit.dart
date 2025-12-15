import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/features/auth/controllers/login_state.dart';
import 'package:asdsmartcare/features/auth/controllers/forget_password_state.dart';
import 'package:asdsmartcare/features/auth/models/login_doctor_model.dart';

import 'package:asdsmartcare/features/auth/models/login_parent_model.dart';
import 'package:bloc/bloc.dart';
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

  String  VerficationCode="";
  

  Future<void> CheckEmail() async {
  emit(ForgetPasswordLoading());
  print(emailController.text);
   
  try {
    // kick off the request and timeout after 10s
    final response = await Diohelper.postData(
      url: ApiConstants.forgotPasswordEmail,
      data: {"email":emailController.text},
    ).timeout(
      const Duration(seconds: 44),
      onTimeout: () => throw Exception("Login request timed out"),
    );
print(response.data);
emit(CheckEmailSuccess());
    
  } catch (e, st) {
    // you’ll see this print in your console
    print("🔴 Login failed: $e\n$st");
    emit(CheckEmailError(e.toString()));
  }
}

  Future<void> CheckVerficationCode() async {
  emit(ForgetPasswordLoading());
  print(emailController.text);
   
  try {
    // kick off the request and timeout after 10s
    final response = await Diohelper.postData(
      url: ApiConstants.forgotPasswordEmailVerfiationCode,
      data: {"resetCode":VerficationCode},
    ).timeout(
      const Duration(seconds: 44),
      onTimeout: () => throw Exception("Login request timed out"),
    );
print(response.data);
emit(ResetPasswordCodeSuccess());
    
  } catch (e, st) {
    // you’ll see this print in your console
    print("🔴 Login failed: $e\n$st");
    emit(ResetPasswordCodeError(e.toString()));
  }
}

  Future<void> ResetPasswordCall() async {
  emit(ForgetPasswordLoading());
  print(emailController.text);
   
  try {
    // kick off the request and timeout after 10s
    final response = await Diohelper.postData(
      url: ApiConstants.ResetPassword,
      data: 
      { 
    "newPassword":NewPasswordController.text,
    "confirmPassword":ConfirmPasswordController.text
    },
    ).timeout(
      const Duration(seconds: 44),
      onTimeout: () => throw Exception("Login request timed out"),
    );
print(response.data);
emit(ForgetPasswordSuccess());
    
  } catch (e, st) {
    // you’ll see this print in your console
    print("🔴 Login failed: $e\n$st");
    emit(ForgetPasswordError(e.toString()));
  }
}


}




