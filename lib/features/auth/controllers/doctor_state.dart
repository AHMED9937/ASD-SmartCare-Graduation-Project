import 'package:asdsmartcare/features/auth/models/login_doctor_model.dart';
import 'package:asdsmartcare/features/auth/models/login_parent_model.dart';
import 'package:asdsmartcare/features/auth/models/sign_up_parent_model.dart';

abstract class DoctorSignUpState{}


class DoctorSignUpInitialState extends DoctorSignUpState{}
class DoctorSignUpLoadingState extends DoctorSignUpState{}

class DoctorSignUpSuccessState extends DoctorSignUpState{
  
}

class DoctorSignUpErrorState extends DoctorSignUpState{
  final String error;
  DoctorSignUpErrorState(this.error);
}







