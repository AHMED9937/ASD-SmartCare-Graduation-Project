import 'package:asdsmartcare/features/auth/models/login_doctor_model.dart';
import 'package:asdsmartcare/features/auth/models/login_parent_model.dart';
import 'package:asdsmartcare/features/auth/models/sign_up_parent_model.dart';

abstract class ParentSignUpState{}


class ParentSignUpInitialState extends ParentSignUpState{}
class ParentSignUpLoadingState extends ParentSignUpState{}

class ParentSignUpSuccessState extends ParentSignUpState{
  var lum;
  ParentSignUpSuccessState(this.lum);
}

class ParentSignUpErrorState extends ParentSignUpState{
  final String error;
  ParentSignUpErrorState(this.error);

}
class ParentSignUpresetCodeSuccessState extends ParentSignUpState{}
class ParentSignUpresetCodeLoadingState extends ParentSignUpState{}
class ParentSignUpresetCodeErrorState extends ParentSignUpState{}

class DeleteParentSuccessState extends ParentSignUpState{}
class DeleteParentLoadingState extends ParentSignUpState{}
class DeleteParentErrorState extends ParentSignUpState{}

class AddChildSuccessState extends ParentSignUpState{
  var child;
  AddChildSuccessState(child);
}
class AddChildLoadingState extends ParentSignUpState{}
class AddChildErrorState extends ParentSignUpState{}







