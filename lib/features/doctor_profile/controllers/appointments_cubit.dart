import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/features/doctor_profile/controllers/appointments_state.dart';
import 'package:asdsmartcare/features/doctor_profile/models/appointments_response.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorAppointmentListCubit extends Cubit<GetDoctorAppointmentListStates> {
  DoctorAppointmentListCubit() : super(GetDoctorAppointmentListInitialStates());

  static DoctorAppointmentListCubit get(context) => BlocProvider.of(context);

  /// All sessions for the doctor
  AppointmentsResponse? Appointments;

  /// A single session fetched by ID
  Appointment? selectedAppointment;

  /// Fetches the list of sessions filtered by [status].
  Future<void> fetchAppointments({ required String status }) async {
    emit(GetDoctorAppointmentListLoadingStates());
    try {
      final response = await Diohelper.getData(
        url: ApiConstants.GetDoctorAppointments,
        token: CacheHelper.getData(key: "token"),
        query: {"doctorId":CacheHelper.getData(key: "id")}
      );
      print(response.data);
      Appointments = AppointmentsResponse.fromJson(response.data as Map<String, dynamic>);
      emit(GetDoctorAppointmentListSuccessStates());
    } catch (error) {
      print("Error fetching sessions: $error");
      emit(GetDoctorAppointmentListFailedStates());
    }
  }  /// Updates the comments of session with [sid] to [newComments].
  Future<void> updateAppointmentComments() async {
    emit(UpdateDoctorAppointmentLoadingStates());
    try {
      await Diohelper.putData(
        url: ApiConstants.UpdateAppointment,
        token: CacheHelper.getData(key: "token"),
        data: {},
      );
      emit(UpdateDoctorAppointmentSuccessStates());
    } catch (error) {
      print("Error updating session comments: $error");
      emit(UpdateDoctorAppointmentFailedStates());
    }
  }
}




