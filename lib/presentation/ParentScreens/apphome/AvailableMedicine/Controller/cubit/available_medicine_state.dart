// login_state.dart

abstract class AvailableMedicineState {}

class GetAvailableMedicineStateInitial extends AvailableMedicineState {}
class GetAvailableMedicineLoading extends AvailableMedicineState {}

/// Carries either a LoginParentModel or LoginDoctorModel
class GetAvailableMedicineSuccess extends AvailableMedicineState {
  final dynamic userModel;
  GetAvailableMedicineSuccess(this.userModel);
}

class GetAvailableMedicineError extends AvailableMedicineState {
  final String error;
  GetAvailableMedicineError(this.error);
}

