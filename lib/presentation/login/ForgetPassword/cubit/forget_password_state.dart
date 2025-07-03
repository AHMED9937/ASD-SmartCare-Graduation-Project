// login_state.dart

abstract class ForgetPasswordstate {}

class ForgetPasswordInitial extends ForgetPasswordstate {}
class ForgetPasswordLoading extends ForgetPasswordstate {}

class ForgetPasswordSuccess extends ForgetPasswordstate {}

class ForgetPasswordError extends ForgetPasswordstate {
  final String error;
 ForgetPasswordError(this.error);
}

class ResetPasswordCodeSuccess extends ForgetPasswordstate {}

class ResetPasswordCodeError extends ForgetPasswordstate {
  final String error;
 ResetPasswordCodeError(this.error);
}


class CheckEmailSuccess extends ForgetPasswordstate {
  
}
class CheckEmailError extends ForgetPasswordstate {
  final String error;
 CheckEmailError(this.error);
}
/// Carries either a LoginParentModel or LoginDoctorModel
