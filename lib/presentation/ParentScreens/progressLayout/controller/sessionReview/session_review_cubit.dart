import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/cubit/doctors_list_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/controller/childProgress/child_progress_state.dart';
import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/controller/sessionReview/session_review_state.dart';
import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/model/GetAllSession.dart';
import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/model/ParentBookedDoctors.dart';
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

    Diohelper.PostData(
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

  void submitDoctorReview(String DoctorId) {
    print(DoctorId);
    print(controller.text);
    print(rating);

    emit(DoctorReviewStateLoading());

    Diohelper.PostData(
      url: ApiConstants.AddDoctorReview(
          DoctorId), // Ensure this matches your API endpoint key
      data: {"title": controller.text, "ratings": rating},
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      print(value.data);

      emit(DoctorReviewStateLoaded());
    }).catchError((error) {
      print("Error ");
      emit(DoctorReviewStateError());
    });
  }

  void updateRating(int r) {
    rating = r;
    emit(updateRatingState());
  }


}
