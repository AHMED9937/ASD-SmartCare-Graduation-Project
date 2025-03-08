import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginParentModel.dart';

abstract class UserLoginState{}


class UserLoginInitialState extends UserLoginState{}
class UserLoginLoadingState extends UserLoginState{}

class UserLoginSuccessState extends UserLoginState{
  final LoginUserModel  myUsermodel;
  UserLoginSuccessState(this.myUsermodel);

}

class UserLoginErrorState extends UserLoginState{
  final String error;
  UserLoginErrorState(this.error);
}
class remebermeState extends UserLoginState{}
class changePasswordVisibltyState extends UserLoginState{}


class ParentLoginSuccessState extends UserLoginState{
  final LoginParentmodel  myParentmodel;
  ParentLoginSuccessState(this.myParentmodel);

}

class DoctorLoginSuccessState extends UserLoginState{
  final LoginDoctorModel  myDoctormodel;
  DoctorLoginSuccessState(this.myDoctormodel);

}