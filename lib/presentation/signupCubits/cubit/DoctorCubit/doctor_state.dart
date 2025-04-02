import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginParentModel.dart';
import 'package:asdsmartcare/presentation/signupCubits/Model/SignUpParentModel.dart';

abstract class DoctorSignUpState{}


class DoctorSignUpInitialState extends DoctorSignUpState{}
class DoctorSignUpLoadingState extends DoctorSignUpState{}

class DoctorSignUpSuccessState extends DoctorSignUpState{
  
  // SignupDoctorModel lum;
  // ParentSignUpSuccessState(this.lum);
}

class DoctorSignUpErrorState extends DoctorSignUpState{
  final String error;
  DoctorSignUpErrorState(this.error);
}