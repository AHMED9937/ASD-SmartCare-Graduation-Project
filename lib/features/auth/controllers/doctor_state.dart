import 'package:asdsmartcare/features/auth/models/LoginDoctorModel.dart';
import 'package:asdsmartcare/features/auth/models/loginParentModel.dart';
import 'package:asdsmartcare/features/auth/models/SignUpParentModel.dart';

abstract class DoctorSignUpState{}


class DoctorSignUpInitialState extends DoctorSignUpState{}
class DoctorSignUpLoadingState extends DoctorSignUpState{}

class DoctorSignUpSuccessState extends DoctorSignUpState{
  
}

class DoctorSignUpErrorState extends DoctorSignUpState{
  final String error;
  DoctorSignUpErrorState(this.error);
}







