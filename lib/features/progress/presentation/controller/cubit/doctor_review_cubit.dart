import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/features/doctors/presentation/doctors_list/cubit/doctors_list_cubit.dart';
import 'package:asdsmartcare/features/progress/presentation/controller/childProgress/child_progress_state.dart';
import 'package:asdsmartcare/features/progress/presentation/controller/cubit/doctor_review_state.dart';
import 'package:asdsmartcare/features/progress/presentation/model/GetAllSession.dart';
import 'package:asdsmartcare/features/progress/presentation/model/ParentBookedDoctors.dart';
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
    emit(updateSessionRatingState());
  }


}
