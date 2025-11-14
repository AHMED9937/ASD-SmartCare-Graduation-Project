import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/doctor/sessions/list/controllers/sessions_list_state.dart';
import 'package:asdsmartcare/doctor/sessions/list/models/session_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorSessionListCubit extends Cubit<GetDoctorSessionListStates> {
  DoctorSessionListCubit() : super(GetDoctorSessionListInitialStates());

  static DoctorSessionListCubit get(context) => BlocProvider.of(context);

  /// All sessions for the doctor
  SessionsResponse? sessions;

  /// A single session fetched by ID
  Session? selectedSession;

  /// Fetches the list of sessions filtered by [status].
  Future<void> fetchSessions({required String status}) async {
    emit(GetDoctorSessionListLoadingStates());
    try {
      final response = await Diohelper.getData(
        url: ApiConstants.GetDoctorSesstionList(status),
        token: CacheHelper.getData(key: 'token'),
      );
      sessions =
          SessionsResponse.fromJson(response.data as Map<String, dynamic>);
      emit(GetDoctorSessionListSuccessStates());
    } catch (error) {
      debugPrint('Error fetching sessions: $error');
      emit(GetDoctorSessionListFailedStates());
    }
  }

  /// Fetches a single session by [id].
  Future<void> fetchSessionById(String sessionId) async {
    emit(GetSpecificSessionLoadingStates());
    try {
      final response = await Diohelper.getData(
        url: ApiConstants.getSpecificSession(sessionId),
        token: CacheHelper.getData(key: 'token'),
      );
      final json = response.data as Map<String, dynamic>;

      // If the API wraps it in { data: [...] }
      if (json['data'] is List) {
        selectedSession = SessionsResponse.fromJson(json).data?.first;
      }
      // If the API wraps it in { data: { ... } }
      else if (json['data'] is Map<String, dynamic>) {
        selectedSession =
            Session.fromJson(json['data'] as Map<String, dynamic>);
      }
      // Or if it returns the session object directly
      else {
        selectedSession = Session.fromJson(json);
      }

      emit(GetSpecificSessionSuccessStates());
    } catch (error) {
      debugPrint('Error fetching specific session: $error');
      emit(GetSpecificSessionFailedStates());
    }
  }

  /// Updates the comments of session with [sid] to [newComments].
  Future<void> updateSessionComments(
      List<String> newComments, String sessionId) async {
    emit(UpdateDoctorSessionLoadingStates());
    try {
      await Diohelper.putData(
        url: ApiConstants.updateSession(sessionId),
        token: CacheHelper.getData(key: 'token'),
        data: {'comments': newComments},
      );
      emit(UpdateDoctorSessionSuccessStates());
    } catch (error) {
      debugPrint('Error updating session comments: $error');
      emit(UpdateDoctorSessionFailedStates());
    }
  }
}
