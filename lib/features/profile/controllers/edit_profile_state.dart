import 'package:asdsmartcare/features/auth/models/LoginDoctorModel.dart';
import 'package:asdsmartcare/features/auth/models/loginParentModel.dart';
import 'package:asdsmartcare/features/auth/models/SignUpParentModel.dart';

abstract class EditParentProfileState{}


class EditParentProfileInitialState extends EditParentProfileState{}
class EditParentProfileLoadingState extends EditParentProfileState{}

class EditParentProfileSuccessState extends EditParentProfileState{
  
}

class EditParentProfilePhotoPicked extends EditParentProfileState{
  
}
class EditParentProfileErrorState extends EditParentProfileState{
  final String error;
  EditParentProfileErrorState(this.error);
}







