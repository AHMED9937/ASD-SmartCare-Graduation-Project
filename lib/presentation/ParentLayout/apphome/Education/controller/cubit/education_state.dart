// login_state.dart

abstract class AvailableEducationArticaleState {}

class GetAvailableEducationArticaleStateInitial extends AvailableEducationArticaleState {}
class GetAvailableEducationArticaleLoading extends AvailableEducationArticaleState {}

/// Carries either a LoginParentModel or LoginDoctorModel
class GetAvailableEducationArticaleSuccess extends AvailableEducationArticaleState {
  final dynamic userModel;
  GetAvailableEducationArticaleSuccess(this.userModel);
}

class GetAvailableEducationArticaleError extends AvailableEducationArticaleState {
  final String error;
  GetAvailableEducationArticaleError(this.error);
}

