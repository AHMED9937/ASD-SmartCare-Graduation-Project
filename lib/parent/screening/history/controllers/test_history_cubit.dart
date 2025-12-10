import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/parent/screening/history/controllers/test_history_state.dart';
import 'package:asdsmartcare/parent/screening/history/models/test_level_model.dart';
import 'package:asdsmartcare/parent/screening/history/models/test_history_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestHistoryCubit extends Cubit<GetTestHistoryStates> {
  TestHistoryCubit() : super(GetTestHistoryinitialStates());

  HistoryAutisumTest? His_autisumTest;
  HistoryAustisumLevelTest? His_autisumLevelTest;

  static TestHistoryCubit get(context) => BlocProvider.of(context);
  void GetAutismTestHistory() {
    emit(GetAutisumTestHistoryLoadingStates());

    Diohelper.getData(
          url: ApiConstants
              .GetAutismTestHistory, // Ensure this matches your API endpoint key
          token: CacheHelper.getData(key: 'token'),
        )
        .then((value) {
          debugPrint('Fetched autism test history');
          His_autisumTest = HistoryAutisumTest.fromJson(value.data);
          emit(GetAutisumTestHistorySuccsessStates());
        })
        .catchError((error) {
          debugPrint('Error fetching autism test history: $error');
          emit(GetAutisumTestHistoryFailedStates());
        });
  }

  void GetAutismLevelTestHistory() {
    emit(GetAutisumLevelTestHistoryLoadingStates());

    Diohelper.getData(
          url: ApiConstants
              .GetAutismLevelTestHistory, // Ensure this matches your API endpoint key
          token: CacheHelper.getData(key: 'token'),
        )
        .then((value) {
          debugPrint('Fetched autism level test history');
          His_autisumLevelTest = HistoryAustisumLevelTest.fromJson(value.data);

          emit(GetAutisumLevelTestHistorySuccsessStates());
        })
        .catchError((error) {
          debugPrint('Error fetching autism level test history: $error');
          emit(GetAutisumLevelTestHistoryFailedStates());
        });
  }
}
