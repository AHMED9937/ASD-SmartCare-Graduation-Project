import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginParentModel.dart';

abstract class SignUpStates{}


class SignUpInitialState extends SignUpStates{}
class SignUpLoadingState extends SignUpStates{}

class SignUpSuccessState extends SignUpStates{
  LoginUserModel lum;
  SignUpSuccessState(this.lum);
}

class SignUpErrorState extends SignUpStates{
  final String error;
  SignUpErrorState(this.error);
}


class changePasswordVisibltyState extends SignUpStates{}



class SignUpresetCodeLoadingState extends SignUpStates{}
class SignUpresetCodeSuccessState extends SignUpStates{}
class SignUpresetCodeErrorState extends SignUpStates{}
