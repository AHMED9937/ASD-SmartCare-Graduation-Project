import 'package:asdsmartcare/features/auth/presentation/login/model/LoginDoctorModel.dart';
import 'package:asdsmartcare/features/auth/presentation/login/model/loginParentModel.dart';
import 'package:asdsmartcare/features/auth/presentation/signup/Model/SignUpParentModel.dart';

abstract class DoctorSignUpState{}


class DoctorSignUpInitialState extends DoctorSignUpState{}
class DoctorSignUpLoadingState extends DoctorSignUpState{}

class DoctorSignUpSuccessState extends DoctorSignUpState{
  
}

class DoctorSignUpErrorState extends DoctorSignUpState{
  final String error;
  DoctorSignUpErrorState(this.error);
}