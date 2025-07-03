import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginParentModel.dart';
import 'package:asdsmartcare/presentation/SignUp/Model/SignUpParentModel.dart';

abstract class DoctorSignUpState{}


class DoctorSignUpInitialState extends DoctorSignUpState{}
class DoctorSignUpLoadingState extends DoctorSignUpState{}

class DoctorSignUpSuccessState extends DoctorSignUpState{
  
}

class DoctorSignUpErrorState extends DoctorSignUpState{
  final String error;
  DoctorSignUpErrorState(this.error);
}