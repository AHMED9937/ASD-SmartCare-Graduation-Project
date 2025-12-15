import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/features/doctors/controllers/doctors_list_cubit.dart';
import 'package:asdsmartcare/features/progress/controllers/childProgress/child_progress_state.dart';
import 'package:asdsmartcare/features/progress/controllers/doctor_review_state.dart';
import 'package:asdsmartcare/features/progress/models/GetAllSession.dart';
import 'package:asdsmartcare/features/progress/models/ParentBookedDoctors.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';

class DoctorReviewCubit extends Cubit<DoctorReviewStates> {

  DoctorReviewCubit() :super(DoctorReviewStateInitial());

  static DoctorReviewCubit get(context) => BlocProvider.of(context);
  int rating = 0;
  final TextEditingController controller = TextEditingController();

 void submitDoctorReview(String DoctorId) {
  print(DoctorId);
    print(DoctorId);
    print(controller.text);
    print(rating);

    emit(DoctorReviewStateLoading());

    Diohelper.postData(
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
    emit(updateSessionRatingState());
  }


}








