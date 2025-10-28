abstract class DoctorReviewStates {}

class DoctorReviewStateInitial extends DoctorReviewStates {}

class DoctorReviewStateLoading extends DoctorReviewStates {}

class DoctorReviewStateLoaded extends DoctorReviewStates {}

class DoctorReviewStateError extends DoctorReviewStates {}

class UpdateDoctorRatingState extends DoctorReviewStates {}
