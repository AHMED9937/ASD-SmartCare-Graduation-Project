import 'package:asdsmartcare/features/auth/models/login_doctor_model.dart';
import 'package:asdsmartcare/features/auth/models/login_parent_model.dart';
import 'package:asdsmartcare/features/auth/models/sign_up_parent_model.dart';

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



