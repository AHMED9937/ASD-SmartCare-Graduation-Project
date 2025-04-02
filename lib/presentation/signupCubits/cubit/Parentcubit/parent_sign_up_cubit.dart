import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/signupCubits/Model/SignUpParentModel.dart';
import 'package:asdsmartcare/presentation/signupCubits/cubit/Parentcubit/parent_sign_up_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentSignUpCubit extends Cubit<ParentSignUpState> {
  ParentSignUpCubit() : super(ParentSignUpInitialState());

  static ParentSignUpCubit get(context) => BlocProvider.of(context);
  var formKey = GlobalKey<FormState>();
  String? userToken;

  // Parent Form Controller
  var childNametextcontroller = TextEditingController();
  var birthdaytextcontroller = TextEditingController();
  var gendertextcontroller = TextEditingController();
  var addresstextcontroller = TextEditingController();

  List<TextEditingController?> Pintextcontroller = [];

  late SignupParentModel signupparentmodel;

  String? verificationCode;

  void ParentSignUp() {
    if (CacheHelper.getData(key: "token") == null) {
      emit(ParentSignUpErrorState("No token found"));
      return;
    }

    emit(ParentSignUpLoadingState());

    Diohelper.PostData(
      url: ApiConstants.singupForParent,
      data: {
        "childName": childNametextcontroller.text,
        "birthday": birthdaytextcontroller.text,
        "gender": gendertextcontroller.text,
        "address": addresstextcontroller.text,
      },
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        signupparentmodel = SignupParentModel.fromJson(value.data);
        emit(ParentSignUpSuccessState(signupparentmodel));
      } else {
        emit(ParentSignUpErrorState("Server Error: ${value.statusCode}"));
      }
    }).catchError((onError) {
      // Improved error handling
      if (onError is DioException) {
        if (onError.response != null) {
          // Check for a response body in case of 500 or other server errors
          print("Dio error response: ${onError.response?.data["message"]}");
          emit(ParentSignUpErrorState("${onError.response?.data["message"]}"));
        } else {
          // If there is no response, it's most likely a network issue or timeout
          print("Dio error message: ${onError.message}");
          emit(ParentSignUpErrorState("Network error: ${onError.message}"));
        }
      } else {
        print("General error: ${onError.toString()}");
        emit(ParentSignUpErrorState("Unexpected error occurred"));
      }
    });
  }
}
