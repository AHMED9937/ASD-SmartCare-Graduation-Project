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

