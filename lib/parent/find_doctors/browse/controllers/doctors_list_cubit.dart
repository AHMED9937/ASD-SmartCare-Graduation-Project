import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/controllers/doctors_list_state.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/models/doctor_model.dart';

/// Cubit for fetching and managing the list of doctors.
class DoctorsListCubit extends Cubit<GetDoctorsListStates> {
  DoctorsListCubit() : super(GetDoctorsListInitialState());

  DoctorList? doctorListRes;
  List<Doctor> myDoctorList = [];

  static DoctorsListCubit get(BuildContext context) => BlocProvider.of(context);
  final List<Map<String, String>> doctors = [];
  Doctor? selectedDoctor;

  void getDoctorsList({bool recommendedDoctor = false}) {
    emit(GetDoctorsListLoadingState());

    Diohelper.getData(
          url: ApiConstants.GetDoctorsList,
          token: CacheHelper.getData(key: 'token'),
          query: recommendedDoctor ? {'sort': '-ratingsAverage'} : null,
        )
        .then((value) {
          doctorListRes = DoctorList.fromJson(value.data);
          myDoctorList = doctorListRes?.data ?? [];
          debugPrint('Loaded ${myDoctorList.length} doctors from API');
          emit(GetDoctorsListSuccessState());
        })
        .catchError((error) {
          debugPrint('Error fetching doctors list: $error');
          emit(GetDoctorsListFailedState());
        });
  }

  void searchDoctorsList({String? byName, bool? byRating}) {
    emit(GetDoctorsListLoadingState());

    Diohelper.getData(
          url: ApiConstants.GetDoctorsList,
          token: CacheHelper.getData(key: 'token'),
          query: {'keyword': byName, 'sort': '-ratingsAverage'},
        )
        .then((value) {
          doctorListRes = DoctorList.fromJson(value.data);
          myDoctorList = doctorListRes?.data ?? [];
          debugPrint('Search returned ${myDoctorList.length} doctors');
          emit(GetDoctorsListSuccessState());
        })
        .catchError((error) {
          debugPrint('Error fetching doctors list: $error');
          emit(GetDoctorsListFailedState());
        });
  }
}
