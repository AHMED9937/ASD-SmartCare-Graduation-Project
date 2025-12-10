import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/parent/progress/controllers/doctor_review_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorReviewCubit extends Cubit<DoctorReviewStates> {
  DoctorReviewCubit() : super(DoctorReviewStateInitial());

  static DoctorReviewCubit get(context) => BlocProvider.of(context);
  int rating = 0;
  final TextEditingController controller = TextEditingController();

  void submitDoctorReview(String doctorId) {
    debugPrint('Submitting review for doctor: $doctorId');

    emit(DoctorReviewStateLoading());

    Diohelper.postData(
          url: ApiConstants.AddDoctorReview(
            doctorId,
          ), // Ensure this matches your API endpoint key
          data: {'comment': controller.text, 'rating': rating},
          token: CacheHelper.getData(key: 'token'),
        )
        .then((value) {
          debugPrint('Doctor review submitted successfully');

          emit(DoctorReviewStateLoaded());
        })
        .catchError((error) {
          debugPrint('Error submitting doctor review: $error');
          emit(DoctorReviewStateError());
        });
  }

  void updateRating(int r) {
    rating = r;
    emit(UpdateDoctorRatingState());
  }
}
