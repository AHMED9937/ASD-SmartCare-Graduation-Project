import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/parent/account/controllers/parent_profile_state.dart';
import 'package:asdsmartcare/parent/account/models/parent_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetParentDataCubit extends Cubit<GetParentDataStates> {
  GetParentDataCubit() : super(GetParentDataInitialStates());

  static GetParentDataCubit get(context) => BlocProvider.of(context);
  GetLoggedParentData? currentParent;

  void getParentData() {
    emit(GetParentDataLoadingStates());

    Diohelper.getData(
      url: ApiConstants.getParentDataMe,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      debugPrint('Fetched parent data');
      currentParent = GetLoggedParentData.fromJson(value.data);
      emit(GetParentDataSuccessStates());
    }).catchError((error) {
      debugPrint('Error fetching parent data: $error');
      emit(GetParentDataFailedStates());
    });
  }
}
