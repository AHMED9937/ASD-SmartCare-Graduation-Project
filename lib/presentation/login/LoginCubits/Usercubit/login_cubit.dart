import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/login/LoginCubits/Usercubit/login_state.dart';
import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';

import 'package:asdsmartcare/presentation/login/model/loginParentModel.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(LoginInitial());

  static UserLoginCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscureText = true;
  Icon visibilityIcon = Icon(Icons.visibility);
  bool userRememberMe = false;

  late LoginParentModel parentModel;
  late LoginDoctorModel doctorModel;

  void changePasswordVisibility() {
    isObscureText = !isObscureText;
    visibilityIcon = isObscureText
        ? Icon(Icons.visibility_off_outlined)
        : Icon(Icons.visibility);
    emit(ChangePasswordVisibilityState());
  }

  void rememberMeFunc(bool? value) {
    userRememberMe = value ?? false;
    // Persist the choice
    CacheHelper.SaveData(key: 'rememberMe', value: userRememberMe);
    emit(RememberMeState());
  }
Future<void> login({
  required String email,
  required String password,
}) async {
  emit(LoginLoading());
    final role = CacheHelper.getData(key: "role");
print(role);
  try {
    // kick off the request and timeout after 10s
    final response = await Diohelper.PostData(
      url: ApiConstants.login,
      data: {"email": email, "password": password},
    ).timeout(
      const Duration(seconds: 44),
      onTimeout: () => throw Exception("Login request timed out"),
    );
print(response.data);

    print(role);
    if (role == 'parent') {
      parentModel = LoginParentModel.fromJson(response.data);
      emit(LoginSuccess(parentModel));
    } else  {
      doctorModel = LoginDoctorModel.fromJson(response.data);
      emit(LoginSuccess(doctorModel));
    } 
  } catch (e, st) {
    // you’ll see this print in your console
    print("🔴 Login failed: $e\n$st");
    emit(LoginError(e.toString()));
  }
}
}
