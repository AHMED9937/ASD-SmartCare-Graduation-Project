// Base class
abstract class ChildProgressState {}

class ChildProgressInitial extends ChildProgressState {}

class GetParentBookedDoctorsInitial extends ChildProgressState {}

class GetParentBookedDoctorsLoading extends ChildProgressState {}

class GetParentBookedDoctorsLoaded extends ChildProgressState {}

class GetParentBookedDoctorsError extends ChildProgressState {}

class GetAllBookedSessionsByStatusInitial extends ChildProgressState {}

class GetAllBookedSessionsByStatusLoading extends ChildProgressState {}

class GetAllBookedSessionsByStatusLoaded extends ChildProgressState {}

class GetAllBookedSessionsByStatusError extends ChildProgressState {}

class GetAutisumLevelTestHistoryLoading extends ChildProgressState {}

class GetAutisumLevelTestHistoryLoaded extends ChildProgressState {}

class GetAutisumLevelTestHistoryError extends ChildProgressState {}

class UnifiedProgressDataLoading extends ChildProgressState {}

class UnifiedProgressDataLoaded extends ChildProgressState {}

class UnifiedProgressDataError extends ChildProgressState {}
