import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_state.dart';
import 'package:asdsmartcare/parent/progress/models/session_model.dart';
import 'package:asdsmartcare/parent/progress/models/booked_doctors_model.dart';
import 'package:asdsmartcare/parent/screening/history/models/test_level_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChildProgressCubit extends Cubit<ChildProgressState> {
  ChildProgressCubit() : super(ChildProgressInitial());
  List<Doctors>? myDoctorList = [];
  static ChildProgressCubit get(context) => BlocProvider.of(context);
  int current = 0;
  List<SessionData> sessions = [];
  HistoryAustisumLevelTest? autismLevelHistory;

  void getAllBookedDoctorsForParent() {
    emit(GetParentBookedDoctorsLoading());

    Diohelper.getData(
      url: ApiConstants
          .GetParentBookedDoctors, // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      myDoctorList = ParentBookedDoctors.fromJson(value.data).doctors;
      debugPrint('Loaded ${myDoctorList?.length ?? 0} booked doctors');
      //print(myDoctorList.data[0]);
      emit(GetParentBookedDoctorsLoaded());
    }).catchError((error) {
      debugPrint('Error fetching booked doctors: $error');
      emit(GetParentBookedDoctorsError());
    });
  }

  void getAllUpcomingSessionsForParent(String id, bool isComming) {
    emit(GetAllBookedSessionsByStatusLoading());

    Diohelper.getData(
      url: ApiConstants.GetAllSessionForSpecificParentAndDoctorByStatus(
          id,
          isComming
              ? 'coming'
              : 'done'), // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      debugPrint('Loaded ${sessions.length} sessions');
      emit(GetAllBookedSessionsByStatusLoaded());
    }).catchError((error) {
      debugPrint('Error fetching sessions: $error');
      emit(GetAllBookedSessionsByStatusError());
    });
  }

  void getAutismLevelTestHistory() {
    emit(GetAutisumLevelTestHistoryLoading());

    Diohelper.getData(
      url: ApiConstants.GetAutismLevelTestHistory,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      autismLevelHistory = HistoryAustisumLevelTest.fromJson(value.data);
      emit(GetAutisumLevelTestHistoryLoaded());
    }).catchError((error) {
      debugPrint('Error fetching autism level history: $error');
      emit(GetAutisumLevelTestHistoryError());
    });
  }

  /// Unified initial fetch that waits for all 3 data sources
  Future<void> initialFetchUnifiedData(bool isComming) async {
    emit(UnifiedProgressDataLoading());

    try {
      // 1. Fetch Doctors and Autism Level in parallel
      final doctorsFuture = Diohelper.getData(
        url: ApiConstants.GetParentBookedDoctors,
        token: CacheHelper.getData(key: 'token'),
      );

      final historyFuture = Diohelper.getData(
        url: ApiConstants.GetAutismLevelTestHistory,
        token: CacheHelper.getData(key: 'token'),
      );

      final results = await Future.wait([doctorsFuture, historyFuture]);

      // Handle Doctors
      myDoctorList = ParentBookedDoctors.fromJson(results[0].data).doctors;

      // Handle History
      autismLevelHistory = HistoryAustisumLevelTest.fromJson(results[1].data);

      // 2. Fetch Sessions if we have at least one doctor
      if (myDoctorList != null && myDoctorList!.isNotEmpty) {
        final sessionsResponse = await Diohelper.getData(
          url: ApiConstants.GetAllSessionForSpecificParentAndDoctorByStatus(
            myDoctorList![current].id ?? '',
            isComming ? 'coming' : 'done',
          ),
          token: CacheHelper.getData(key: 'token'),
        );
        sessions = GetAllSessions.fromJson(sessionsResponse.data).data ?? [];
      } else {
        sessions = [];
      }

      emit(UnifiedProgressDataLoaded());
    } catch (e) {
      debugPrint('Error in unified initial fetch: $e');
      emit(UnifiedProgressDataError());
    }
  }
}
