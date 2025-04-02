import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginParentModel.dart';
import 'package:asdsmartcare/presentation/signupCubits/Model/SignUpParentModel.dart';

abstract class ParentSignUpState{}


class ParentSignUpInitialState extends ParentSignUpState{}
class ParentSignUpLoadingState extends ParentSignUpState{}

class ParentSignUpSuccessState extends ParentSignUpState{
  SignupParentModel lum;
  ParentSignUpSuccessState(this.lum);
}

class ParentSignUpErrorState extends ParentSignUpState{
  final String error;
  ParentSignUpErrorState(this.error);
}