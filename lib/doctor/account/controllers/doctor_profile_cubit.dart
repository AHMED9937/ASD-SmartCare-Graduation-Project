import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/doctor/account/controllers/doctor_profile_state.dart';
import 'package:asdsmartcare/doctor/account/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetDoctorDataCubit extends Cubit<GetDoctorDataStates> {
  GetDoctorDataCubit() : super(GetDoctorDatainitialStates());

  static GetDoctorDataCubit get(BuildContext context) =>
      BlocProvider.of(context);
  GetLoggedDoctorData? currentDoctor;

  void getDoctorData() {
    emit(GetDoctorDataLoadingStates());

    Diohelper.getData(
          url: ApiConstants
              .GetDoctorData, // Ensure this matches your API endpoint key
          token: CacheHelper.getData(key: 'token'),
        )
        .then((value) {
          debugPrint('${value.data}');
          currentDoctor = GetLoggedDoctorData.fromJson(value.data);
          emit(GetDoctorDataSuccsessStates());
        })
        .catchError((error) {
          debugPrint('Error fetching doctors list: $error');
          emit(GetDoctorDataFailedStates());
        });
  }
}
