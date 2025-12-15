import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/features/doctors/controllers/doctors_list_cubit.dart';
import 'package:asdsmartcare/features/progress/controllers/child_progress_state.dart';
import 'package:asdsmartcare/features/progress/controllers/session_review_state.dart';
import 'package:asdsmartcare/features/progress/models/get_all_session.dart';
import 'package:asdsmartcare/features/progress/models/parent_booked_doctors.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class SessionReviewCubit extends Cubit<SessionReviewState> {

  SessionReviewCubit() :super(SessionReviewStateInitial());

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
      data: {"title": controller.text, "ratings": rating},
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      print(value.data);
      //print(myDoctorList.data[0]);
      emit(SessionReviewStateLoaded());
    }).catchError((error) {
      print("Error fetching doctors list: $error");
      emit(SessionReviewStateError());
    });
  }

 void updateRating(int r) {
    rating = r;
    emit(updateDoctorRatingState());
  }


}








