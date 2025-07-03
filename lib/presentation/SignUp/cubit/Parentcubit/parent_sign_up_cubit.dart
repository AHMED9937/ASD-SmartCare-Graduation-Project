import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/SignUp/Model/AddParent.dart';
import 'package:asdsmartcare/presentation/SignUp/Model/SignUpParentModel.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/Parentcubit/parent_sign_up_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ParentSignUpCubit extends Cubit<ParentSignUpState> {
  ParentSignUpCubit() : super(ParentSignUpInitialState());

  static ParentSignUpCubit get(context) => BlocProvider.of(context);
  var formKey = GlobalKey<FormState>();
  String? userToken;
  var addParentFormKey=GlobalKey<FormState>();
  // Parent Form Controller
  var userNametextcontroller = TextEditingController();
  var emailtextcontroller = TextEditingController();
  var phonetextcontroller = TextEditingController();
  var passwordtextcontroller = TextEditingController();
  var confirmPasswordtextcontroller = TextEditingController();
  var Agetextcontroller = TextEditingController();
  var addresstextcontroller = TextEditingController();
  // Add Child Form 
  var ChildNametextcontroller = TextEditingController();
  var ChildAgetextcontroller = TextEditingController();
  var ChildGendertextcontroller = TextEditingController();

  List<Widget> ParentChilds=[  ];
  

  List<TextEditingController?> Pintextcontroller = [];

  late SignupParentResponseModel signUpResponseModel;
  late ChildResponse ChildResponseModel;

  String? verificationCode;
void verifyemail() {
    emit(ParentSignUpresetCodeLoadingState());
       
   
    Diohelper.PostData(
      url: ApiConstants.verifyemail,
      data: {
       "resetCode":verificationCode,
        
      },
    ).then((value) {
      print(value);
      emit(ParentSignUpresetCodeSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ParentSignUpresetCodeErrorState());
    });
  }
void ParentSignUp() {
  

  emit(ParentSignUpLoadingState());

  Diohelper.PostData(
    url: ApiConstants.singupForParent,
    data: {
      "userName":        userNametextcontroller.text,
      "email":           emailtextcontroller.text,
      "phone":           phonetextcontroller.text,
      "password":        passwordtextcontroller.text,
      "confirmPassword": confirmPasswordtextcontroller.text,
      "age":             int.parse(Agetextcontroller.text),
      "address":         addresstextcontroller.text,
    },
    token: CacheHelper.getData(key: "token"),
  ).then((response) {
    final data = response.data as Map<String, dynamic>;

    // If there's an errors array, pull out only the msg fields
    if (data['errors'] != null) {
      final errors = data['errors'] as List<dynamic>;
      final msg = errors
          .map((e) => e['msg'] as String)
          .join('\n'); // join multiple messages with newline
      emit(ParentSignUpErrorState(msg));
      return;
    }

    // Otherwise success
    signUpResponseModel = SignupParentResponseModel.fromJson(data);
    CacheHelper.SaveData(key: "token", value: signUpResponseModel.token);
    emit(ParentSignUpSuccessState(signUpResponseModel));
  }).catchError((err) {
    if (err is DioError &&
        err.response?.data is Map<String, dynamic> &&
        (err.response!.data as Map<String, dynamic>)['errors'] != null) {
      final errors = (err.response!.data as Map<String, dynamic>)['errors'] as List<dynamic>;
      final msg = errors.map((e) => e['msg'] as String).join('\n');
      emit(ParentSignUpErrorState(msg));
    } else {
      emit(ParentSignUpErrorState(err.toString()));
    }
  });
}
void DeleteParent({required  final String ParentId,required final String ParentUserName})
  {
    emit(DeleteParentLoadingState());

    Diohelper.DeleteData(
      url:"${ApiConstants.DeleteSpecificParent}${ParentId}" ,
      data: 
      {
        "userName":ParentUserName,
      },
    ).then((value){
      print(value);
      emit(DeleteParentSuccessState());
    }).catchError((error){
      emit(DeleteParentErrorState());

    });

    
  }

Future<void> addChild({required String parentId}) async {
  final url = ApiConstants.addChild(parentId);

  emit(AddChildLoadingState());
print (ChildNametextcontroller.text+" "+ChildGendertextcontroller.text+ " "+"${ int.parse(ChildAgetextcontroller.text)}");
  try {
    final response = await Diohelper.PostData(
      url: url,
      data: {
        "childName": ChildNametextcontroller.text,
        "birthday": "2/7/2034",
        "gender": ChildGendertextcontroller.text,
        // parse to int if desired, or leave as String if your API expects a string
        "age": int.parse(ChildAgetextcontroller.text),
      },
      token: CacheHelper.getData(key: "token"),
    );

    final data = response.data as Map<String, dynamic>;

    // Handle API-level validation errors
    if (data['errors'] != null) {
      final errors = data['errors'] as List<dynamic>;
      final msg = errors.map((e) => e['msg'] as String).join('\n');
      emit(AddChildErrorState());
      return;
    }

    // Success: parse and emit
    final childResponse = ChildResponse.fromJson(data);
    emit(AddChildSuccessState(childResponse));
  } on DioError catch (err) {
    String msg;
    final errData = err.response?.data;
    if (errData is Map<String, dynamic> && errData['errors'] != null) {
      final errors = errData['errors'] as List<dynamic>;
      msg = errors.map((e) => e['msg'] as String).join('\n');
    } else {
      msg = err.message ?? 'Unexpected error';
    }
    print(msg);
    emit(AddChildErrorState());
  }
}
}
