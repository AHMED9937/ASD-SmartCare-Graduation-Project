// Cubit
import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/doctor/clinic/controllers/clinic_state.dart';
import 'package:asdsmartcare/doctor/clinic/models/availability_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailabilityCubit extends Cubit<AvailabilityState> {
  AvailabilityCubit() : super(AvailabilityInitial());

  static AvailabilityCubit get(BuildContext context) =>
      BlocProvider.of<AvailabilityCubit>(context);

  GetDoctorAvailability? availabilityDays;

  /// submits the list of available slots to the server
  void submitAvailability(List<Map<String, String>> slots) {
    emit(AvailabilityLoading());
    try {
      Diohelper.postData(
          url: ApiConstants
              .doctorAvailability, // replace with your configured endpoint
          data: {'availableSlots': slots},
          token: CacheHelper.getData(key: 'token'));
      // Optionally inspect response, e.g. statusCode or message
      emit(const AvailabilitySuccess());
    } catch (e) {
      emit(AvailabilityError(e.toString()));
    }
  }

  void GetDocAvailability() {
    emit(GetDoctorAvailabilityLoading());

    Diohelper.getData(
      url: ApiConstants.GetDoctorAvailability(CacheHelper.getData(
          key: 'id')), // replace with your configured endpoint
    ).then((value) {
      print(value.data);
      availabilityDays = GetDoctorAvailability.fromJson(value.data);

      emit(GetDoctorAvailabilitySuccess(model: availabilityDays!));
    }).catchError((e) {
      emit(GetDoctorAvailabilityError(e.toString()));
    });

    // Optionally inspect response, e.g. statusCode or message
  }

  void DeleteDocAvailability(slots) {
    emit(DeleteDoctorAvailabilityLoading());

    Diohelper.deleteData(
      query: {},
      token: CacheHelper.getData(key: 'token'),
      url: ApiConstants.DeleteDoctorAvailability(CacheHelper.getData(
          key: 'id')), // replace with your configured endpoint
    ).then((value) {
      print(value.data);

      emit(DeleteDoctorAvailabilitySuccess(slots: slots));
    }).catchError((e) {
      emit(DeleteDoctorAvailabilityError(e.toString()));
    });

    // Optionally inspect response, e.g. statusCode or message
  }

  Future<void> DeleteAppointmet(String appointmentId) async {
    print(appointmentId);
    emit(DeleteDocAppoimentLoading());

    await Diohelper.deleteData(
      url: ApiConstants
          .DeleteSpacificDoctorApoiment, // replace with your configured endpoint
      query: {'appointmentId': appointmentId},
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print(value.data);

      emit(const DeleteDocAppoimentSuccess());
    }).catchError((e) {
      emit(DeleteDocAppoimentError(e.toString()));
    });
  }
}
