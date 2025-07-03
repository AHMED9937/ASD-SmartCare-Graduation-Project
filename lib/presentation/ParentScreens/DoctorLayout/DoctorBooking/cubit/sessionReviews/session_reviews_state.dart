import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Model/GetSessionReviewsList.dart';

abstract class GetSessionReviewsListStates {}

class GetSessionReviewsListinitialStates extends GetSessionReviewsListStates{}
class GetSessionReviewsListLoadingStates extends GetSessionReviewsListStates{}
class GetSessionReviewsListSuccsessStates extends GetSessionReviewsListStates{
 List<SesstionReview> ?reviews;
 GetSessionReviewsListSuccsessStates(this.reviews);
}
class GetSessionReviewsListFailedStates extends GetSessionReviewsListStates{}