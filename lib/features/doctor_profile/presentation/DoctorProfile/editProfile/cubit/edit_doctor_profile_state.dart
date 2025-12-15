import 'package:asdsmartcare/features/auth/presentation/login/model/LoginDoctorModel.dart';
import 'package:asdsmartcare/features/auth/presentation/login/model/loginParentModel.dart';
import 'package:asdsmartcare/features/auth/presentation/signup/Model/SignUpParentModel.dart';

abstract class EditDoctorProfileState{}


class EditDoctorProfileInitialState extends EditDoctorProfileState{}
class EditDoctorProfileLoadingState extends EditDoctorProfileState{}

class EditDoctorProfileSuccessState extends EditDoctorProfileState{
  
}

class EditDoctorProfilePhotoPicked extends EditDoctorProfileState{
  
}
class EditDoctorProfileErrorState extends EditDoctorProfileState{
  final String error;
  EditDoctorProfileErrorState(this.error);
}