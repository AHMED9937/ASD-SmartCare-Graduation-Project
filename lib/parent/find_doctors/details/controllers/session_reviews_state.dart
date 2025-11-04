import 'package:asdsmartcare/parent/find_doctors/details/models/session_review_model.dart';

abstract class GetSessionReviewsListStates {}

class GetSessionReviewsListInitialState extends GetSessionReviewsListStates {}

class GetSessionReviewsListLoadingState extends GetSessionReviewsListStates {}

class GetSessionReviewsListSuccessState extends GetSessionReviewsListStates {
  List<SessionReview>? reviews;
  GetSessionReviewsListSuccessState(this.reviews);
}

class GetSessionReviewsListFailedState extends GetSessionReviewsListStates {}
