import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/doctor/my_patients/controllers/patients_list_state.dart';
import 'package:asdsmartcare/doctor/my_patients/models/patient_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisteredChildrenListCubit
    extends Cubit<GetRegisteredChildrenListStates> {
  RegisteredChildrenListCubit()
      : super(GetRegisteredChildrenListinitialStates());

  static RegisteredChildrenListCubit get(context) => BlocProvider.of(context);
  RegisteredChildren? registeredchildren;

  /// Call this to go back to the initial (form) state
  void reset() {
    emit(GetRegisteredChildrenListinitialStates());
  }

  void getRegisteredChildrenList() {
    emit(GetRegisteredChildrenListLoadingStates());

    Diohelper.getData(
      url: ApiConstants
          .GetRegisteredChildrenList, // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      debugPrint('${value.data}');
      registeredchildren = RegisteredChildren.fromJson(value.data);

      emit(GetRegisteredChildrenListSuccsessStates());
    }).catchError((error) {
      debugPrint('Error fetching RegisteredChildren list: $error');
      emit(GetRegisteredChildrenListFailedStates());
    });
  }

  void CreateSession(result) {
    emit(CreatSessionLoadingStates());

    Diohelper.postData(
      url: ApiConstants.CreateSessions,
      token: CacheHelper.getData(key: 'token'),
      data: result,
    ).then((value) {
      debugPrint('${value.data}');

      emit(CreatSessionSuccsessStates());
    }).catchError((error) {
      debugPrint('Error fetching RegisteredChildren list: $error');
      emit(CreatSessionFailedStates());
    });
  }
}
