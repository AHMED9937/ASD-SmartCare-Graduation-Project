import 'package:asdsmartcare/features/auth/models/LoginDoctorModel.dart';
import 'package:asdsmartcare/features/auth/models/loginParentModel.dart';
import 'package:asdsmartcare/features/auth/models/SignUpParentModel.dart';

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



