import 'package:dio/dio.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/core/network/dio_factory.dart';
import 'package:asdsmartcare/doctor/appointments/models/appointment_model.dart';

abstract class DoctorAppointmentsRepository {
  Future<AppointmentsResponse> getAppointments(
      {required String doctorId, String? status});
}

class DoctorAppointmentsRepositoryImpl implements DoctorAppointmentsRepository {
  final Dio _dio;

  DoctorAppointmentsRepositoryImpl({Dio? dio})
      : _dio = dio ?? DioFactory.instance.dio;

  @override
  Future<AppointmentsResponse> getAppointments(
      {required String doctorId, String? status}) async {
    final response = await _dio.get(
      ApiConstants.GetDoctorAppointments,
      queryParameters: {'doctorId': doctorId},
    );
    return AppointmentsResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
