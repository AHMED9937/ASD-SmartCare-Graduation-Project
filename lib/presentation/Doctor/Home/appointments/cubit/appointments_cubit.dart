import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/appointments/cubit/appointments_state.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/appointments/model/AppointmentsResponse.dart';
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
        data: {"doctorId":CacheHelper.getData(key: "id")}
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
      await Diohelper.PutData(
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
