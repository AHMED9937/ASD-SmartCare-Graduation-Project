// login_state.dart

abstract class AvailableCharityState {}

class GetAvailableCharityStateInitial extends AvailableCharityState {}
class GetAvailableCharityLoading extends AvailableCharityState {}

/// Carries either a LoginParentModel or LoginDoctorModel
class GetAvailableCharitySuccess extends AvailableCharityState {
  final dynamic userModel;
  GetAvailableCharitySuccess(this.userModel);
}

class GetAvailableCharityError extends AvailableCharityState {
  final String error;
  GetAvailableCharityError(this.error);
}

