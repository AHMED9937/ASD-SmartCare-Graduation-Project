
import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/login/LoginCubits/Usercubit/login_state.dart';
import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginParentModel.dart';
import 'package:asdsmartcare/presentation/signupCubits/Model/ErrorModel.dart';
import 'package:asdsmartcare/presentation/signupCubits/Model/SignUpParentModel.dart';
import 'package:asdsmartcare/presentation/signupCubits/cubit/sign_up_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);
  var formKey = GlobalKey<FormState>();
  String ?userToken;
  //user Form Controller
  var userNametextcontroller = TextEditingController();
  var emailtextcontroller = TextEditingController();
  var passwordtextcontroller = TextEditingController();
  var phonetextcontroller = TextEditingController();
  var confirmPasswordtextcontroller = TextEditingController();






  List<TextEditingController?>  Pintextcontroller = [];
  



  bool isObscureText = true;
  Icon visibility_icon = Icon(Icons.visibility);
  bool UserRememberMe = false;


  late LoginUserModel mylogingusermodel;
  late LoginDoctorModel DoctorloginModel;

  String? verificationCode;
 void userSignUp() {
  emit(SignUpLoadingState());

  Diohelper.PostData(
    url: ApiConstants.singupForUser,
    data: {
      "confirmPassword": confirmPasswordtextcontroller.text,
      "userName": userNametextcontroller.text,
      "phone": phonetextcontroller.text,
      "email": emailtextcontroller.text,
      "password": passwordtextcontroller.text,
    },
  ).then((value) {
    if (value.statusCode == 200) {
      print(value.data);
      mylogingusermodel = LoginUserModel.fromJson(value.data);
      emit(SignUpSuccessState(mylogingusermodel));
    } else {
      emit(SignUpErrorState("Server Error: ${value.statusCode}"));
    }
  }).catchError((onError) {
    if (onError is DioException) {
      if (onError.response != null) {
        List<ErrorModel> errors = [];
        
        // Parse error response for specific fields
        if (onError.response?.data['errors'] != null) {
          for (var error in onError.response?.data['errors']) {
            errors.add(ErrorModel.fromJson(error));
          }
        }

        // Handling the errors from the model
        String errorMessage = '';
        for (var error in errors) {
          if (error.path == 'email') {
            errorMessage += "Email error: ${error.msg}\n";
          } else if (error.path == 'confirmPassword') {
            errorMessage += "Password confirmation error: ${error.msg}\n";
          }
        }

        // Emit the error message to be shown in UI
        if (errorMessage.isNotEmpty) {
          emit(SignUpErrorState(errorMessage));
        } else {
          emit(SignUpErrorState("Dio error response: ${onError.response?.data['message']}"));
        }
      } else {
        print("Dio error message: ${onError.message}");
        emit(SignUpErrorState("Network error: ${onError.message}"));
      }
    } else {
      print("General error: ${onError.toString()}");
      emit(SignUpErrorState("Unexpected error occurred"));
    }
  });
}


   void verifyemail() {
    emit(SignUpresetCodeLoadingState());
       
   
    Diohelper.PostData(
      url: ApiConstants.verifyemail,
      data: {
       "resetCode":verificationCode,
        
      },
    ).then((value) {
      print(value);
      emit(SignUpresetCodeSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SignUpresetCodeErrorState());
    });
  }



}
