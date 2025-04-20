import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginParentModel.dart';
import 'package:asdsmartcare/presentation/SignUp/Model/SignUpParentModel.dart';

abstract class ParentSignUpState{}


class ParentSignUpInitialState extends ParentSignUpState{}
class ParentSignUpLoadingState extends ParentSignUpState{}

class ParentSignUpSuccessState extends ParentSignUpState{
  SignupParentResponseModel lum;
  ParentSignUpSuccessState(this.lum);
}

class ParentSignUpErrorState extends ParentSignUpState{
  final String error;
  ParentSignUpErrorState(this.error);

}
class ParentSignUpresetCodeSuccessState extends ParentSignUpState{}
class ParentSignUpresetCodeLoadingState extends ParentSignUpState{}
class ParentSignUpresetCodeErrorState extends ParentSignUpState{}

class DeleteParentSuccessState extends ParentSignUpState{}
class DeleteParentLoadingState extends ParentSignUpState{}
class DeleteParentErrorState extends ParentSignUpState{}
