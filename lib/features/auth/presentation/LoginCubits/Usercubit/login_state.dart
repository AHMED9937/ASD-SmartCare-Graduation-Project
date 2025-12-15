// login_state.dart

abstract class UserLoginState {}

class LoginInitial extends UserLoginState {}
class LoginLoading extends UserLoginState {}

/// Carries either a LoginParentModel or LoginDoctorModel
class LoginSuccess extends UserLoginState {
  final dynamic userModel;
  LoginSuccess(this.userModel);
}

class LoginError extends UserLoginState {
  final String error;
  LoginError(this.error);
}

class RememberMeState extends UserLoginState {}
class ChangePasswordVisibilityState extends UserLoginState {}
