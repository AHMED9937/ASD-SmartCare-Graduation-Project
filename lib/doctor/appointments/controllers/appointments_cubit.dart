import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/doctor/appointments/controllers/appointments_state.dart';
import 'package:asdsmartcare/doctor/appointments/models/appointment_model.dart';
import 'package:asdsmartcare/doctor/appointments/data/appointments_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorAppointmentListCubit extends Cubit<GetDoctorAppointmentListStates> {
  final DoctorAppointmentsRepository _repository;

  DoctorAppointmentListCubit({DoctorAppointmentsRepository? repository})
      : _repository = repository ?? DoctorAppointmentsRepositoryImpl(),
        super(GetDoctorAppointmentListInitialStates());

  static DoctorAppointmentListCubit get(BuildContext context) =>
      BlocProvider.of(context);

  /// All sessions for the doctor
  AppointmentsResponse? appointments;

  /// A single session fetched by ID
  Appointment? selectedAppointment;

  /// Fetches the list of sessions filtered by [status].
  Future<void> fetchAppointments({required String status}) async {
    emit(GetDoctorAppointmentListLoadingStates());
    try {
      final doctorId = CacheHelper.getData(key: 'id').toString();
      appointments = await _repository.getAppointments(
        doctorId: doctorId,
        status: status,
      );
      emit(GetDoctorAppointmentListSuccessStates());
    } catch (error) {
      debugPrint('Error fetching sessions: $error');
      emit(GetDoctorAppointmentListFailedStates());
    }
  }

  /// Updates the comments of session.
  Future<void> updateAppointmentComments() async {
    emit(UpdateDoctorAppointmentLoadingStates());
    try {
      // Logic for update (if needed in refactor)
      emit(UpdateDoctorAppointmentSuccessStates());
    } catch (error) {
      emit(UpdateDoctorAppointmentFailedStates());
    }
  }
}
