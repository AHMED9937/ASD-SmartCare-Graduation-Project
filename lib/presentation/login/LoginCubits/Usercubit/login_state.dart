import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginParentModel.dart';

abstract class UserLoginState{}


class UserLoginInitialState extends UserLoginState{}
class UserLoginLoadingState extends UserLoginState{}


class DoctorLoginSuccessState extends UserLoginState{
  final LoginDoctorModel  myDoctormodel;
  DoctorLoginSuccessState(this.myDoctormodel);

}

class UserLoginErrorState extends UserLoginState{
  final String error;
  UserLoginErrorState(this.error);
}


class ParentLoginSuccessState extends UserLoginState{
  final LoginParentModel  myParentmodel;
  ParentLoginSuccessState(this.myParentmodel);

}

class remebermeState extends UserLoginState{}
class changePasswordVisibltyState extends UserLoginState{}
