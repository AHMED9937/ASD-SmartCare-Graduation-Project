import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:asdsmartcare/presentation/login/model/loginParentModel.dart';
import 'package:asdsmartcare/presentation/SignUp/Model/SignUpParentModel.dart';

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