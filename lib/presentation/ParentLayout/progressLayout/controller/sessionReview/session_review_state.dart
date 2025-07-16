// Base class
abstract class SessionReviewState {}

class SessionReviewStateInitial extends SessionReviewState {}
class SessionReviewStateLoading extends SessionReviewState {}
class SessionReviewStateLoaded extends SessionReviewState {}
class SessionReviewStateError extends SessionReviewState {}

class DoctorReviewStateLoading extends SessionReviewState {}
class DoctorReviewStateLoaded extends SessionReviewState {}
class DoctorReviewStateError extends SessionReviewState {}


class updateRatingState extends SessionReviewState {}



