import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/login/LoginCubits/Usercubit/login_state.dart';
import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginParentModel.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(UserLoginInitialState());

  static UserLoginCubit get(context) => BlocProvider.of(context);
  var formKey = GlobalKey<FormState>();
  var emailtextcontroller = TextEditingController();
  var passwordtextcontroller = TextEditingController();
  bool isObscureText = true;
  Icon visibility_icon = Icon(Icons.visibility);
  bool UserRememberMe = false;

  late LoginUserModel mylogingusermodel;
  late LoginParentmodel parentloginModel;
  late LoginDoctorModel DoctorloginModel;

  void change_Password_visibilty() {
    isObscureText = !isObscureText;
    visibility_icon = isObscureText
        ? Icon(Icons.visibility_off_outlined)
        : Icon(Icons.visibility);
    emit(changePasswordVisibltyState());
  }

  void RememberMefunc(bool? value) {
    UserRememberMe = value ?? false; // Ensures safety in case value is null
    emit(remebermeState());
  }

  void userLogin(
      {required String email,
      required String Password,
      String userRole = "user"}) {
    emit(UserLoginLoadingState());

    Diohelper.PostData(
      url: ApiConstants.login,
      data: {
        "email": email,
        "password": Password,
      },
    ).then((value) {
      print(value.data);
      emit(UserLoginSuccessState(mylogingusermodel));
    }).catchError((onError) {
      emit(UserLoginErrorState("Invalid Emaile or Password !!"));
    });
  }


  void parentLogin(
      {required String email,
      required String Password,
      String userRole = "parent"}) {
    emit(UserLoginLoadingState());

    Diohelper.PostData(
      url: ApiConstants.Parentlogin,
      data: {
        "email": email,
        "password": Password,
      },
    ).then((value) {
      print(value.data);
      parentloginModel = LoginParentmodel.fromJson(value.data);
      emit(ParentLoginSuccessState(parentloginModel));
    }).catchError((onError) {
      emit(UserLoginErrorState("Invalid Emaile or Password !!"));
    });
  }
  void DoctorLogin(
      {required String email,
      required String Password,
      String userRole = "doctor"}) {
    emit(UserLoginLoadingState());

    Diohelper.PostData(
      url: ApiConstants.doctorlogin,
      data: {
        "email": email,
        "password": Password,
      },
    ).then((value) {
      print(value.data);
      DoctorloginModel = LoginDoctorModel.fromJson(value.data);
      emit(DoctorLoginSuccessState(DoctorloginModel));
    }).catchError((onError) {
      emit(UserLoginErrorState("Invalid Emaile or Password !!"));
    });
  }


}
