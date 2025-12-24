import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/parent/progress/controllers/session_review_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionReviewCubit extends Cubit<SessionReviewState> {
  SessionReviewCubit() : super(SessionReviewStateInitial());

  static SessionReviewCubit get(context) => BlocProvider.of(context);
  int rating = 0;
  final TextEditingController controller = TextEditingController();

  void submitSessionReview(String id) {
    print(id);
    print(controller.text);
    print(rating);

    emit(SessionReviewStateLoading());

    Diohelper.postData(
      url: ApiConstants.SessionReview(
          id), // Ensure this matches your API endpoint key
      data: {'title': controller.text, 'ratings': rating},
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print(value.data);
      //print(myDoctorList.data[0]);
      emit(SessionReviewStateLoaded());
    }).catchError((error) {
      print('Error fetching doctors list: $error');
      emit(SessionReviewStateError());
    });
  }

  void updateRating(int r) {
    rating = r;
    emit(UpdateSessionRatingState());
  }
}
