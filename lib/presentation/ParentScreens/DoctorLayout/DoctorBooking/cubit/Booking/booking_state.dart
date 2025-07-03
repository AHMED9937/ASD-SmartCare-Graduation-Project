// login_state.dart

import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Model/Appointmentbooked.dart';

abstract class BookingState {}

 class BookingInitial extends BookingState {}
class BookingLoading extends BookingState {}

/// Carries either a LoginParentModel or LoginDoctorModel
class BookingSuccess extends BookingState {
  final BookSession AppoimentData;
  BookingSuccess(this.AppoimentData);
}

class BookingError extends BookingState {
  final String error;
  BookingError(this.error);
}

class CancelBookingLoading extends BookingState {}

/// Carries either a LoginParentModel or LoginDoctorModel
class CancelBookingSuccess extends BookingState {
  
  CancelBookingSuccess();
}

class CancelBookingError extends BookingState {
  final String error;
  CancelBookingError(this.error);
}

class GenrateSPSLoading extends BookingState {}

/// Carries either a LoginParentModel or LoginDoctorModel
class GenrateSPSSuccess extends BookingState {
  
  GenrateSPSSuccess();
}

class GenrateSPSError extends BookingState {
  final String error;
  GenrateSPSError(this.error);
}




class GenrateCSCOLoading extends BookingState {}

/// Carries either a LoginParentModel or LoginDoctorModel
class GenrateCSCOsuccess extends BookingState {
  GenrateCSCOsuccess();
}

class GenrateCSCOError extends BookingState {
  final String error;
  GenrateCSCOError(this.error);
}


class GetSessionReviewsLoading extends BookingState {}

/// Carries either a LoginParentModel or LoginDoctorModel
class GetSessionReviewssuccess extends BookingState {
  GetSessionReviewssuccess();
}

class GetSessionReviewsError extends BookingState {
  final String error;
  GetSessionReviewsError(this.error);
}


class LoadeDoctorAvailableDatesLoading extends BookingState {}

/// Carries either a LoginParentModel or LoginDoctorModel
class LoadeDoctorAvailableDatesSuccess extends BookingState {
  
}

class LoadeDoctorAvailableDatesError extends BookingState {
  final String error;
  LoadeDoctorAvailableDatesError(this.error);
}
