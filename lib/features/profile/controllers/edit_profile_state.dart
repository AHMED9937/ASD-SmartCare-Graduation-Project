import 'package:asdsmartcare/features/auth/models/login_doctor_model.dart';
import 'package:asdsmartcare/features/auth/models/login_parent_model.dart';
import 'package:asdsmartcare/features/auth/models/sign_up_parent_model.dart';

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







