import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/parent/find_doctors/details/models/session_review_model.dart';
import 'package:asdsmartcare/parent/find_doctors/details/controllers/session_reviews_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionReviewsListCubit extends Cubit<GetSessionReviewsListStates> {
  SessionReviewsListCubit() : super(GetSessionReviewsListInitialState());

  static SessionReviewsListCubit get(context) => BlocProvider.of(context);
  SessionReviews? DocSessionReviews;
  void getDoctorSessionsReviewsList(String Did) {
    emit(GetSessionReviewsListLoadingState());

    Diohelper.getData(
          url: ApiConstants.getDoctorSessionsReviewsList(
            Did,
          ), // Ensure this matches your API endpoint key
          token: CacheHelper.getData(key: 'token'),
        )
        .then((value) {
          debugPrint('${value.data}');
          DocSessionReviews = SessionReviews.fromJson(value.data);

          emit(GetSessionReviewsListSuccessState(DocSessionReviews!.data));
        })
        .catchError((error) {
          debugPrint('Error fetching SessionReviews list: $error');
          emit(GetSessionReviewsListFailedState());
        });
  }

  void getSessionReviewsList(String Sid) {
    emit(GetSessionReviewsListLoadingState());

    Diohelper.getData(
          url: ApiConstants.GetSessionReviewsList(
            Sid,
          ), // Ensure this matches your API endpoint key
          token: CacheHelper.getData(key: 'token'),
        )
        .then((value) {
          debugPrint('${value.data}');
          DocSessionReviews = SessionReviews.fromJson(value.data);

          emit(GetSessionReviewsListSuccessState(DocSessionReviews!.data));
        })
        .catchError((error) {
          debugPrint('Error fetching SessionReviews list: $error');
          emit(GetSessionReviewsListFailedState());
        });
  }
}
