import 'package:asdsmartcare/features/doctors/models/get_session_reviews_list.dart';

abstract class GetSessionReviewsListStates {}

class GetSessionReviewsListinitialStates extends GetSessionReviewsListStates{}
class GetSessionReviewsListLoadingStates extends GetSessionReviewsListStates{}
class GetSessionReviewsListSuccsessStates extends GetSessionReviewsListStates{
 List<SesstionReview> ?reviews;
 GetSessionReviewsListSuccsessStates(this.reviews);
}
class GetSessionReviewsListFailedStates extends GetSessionReviewsListStates{}







