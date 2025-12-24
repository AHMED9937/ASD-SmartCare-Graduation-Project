import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/parent/account/models/parent_model.dart';
import 'package:asdsmartcare/parent/account/controllers/parent_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetParentDataCubit extends Cubit<GetParentDataStates> {
  GetParentDataCubit() : super(GetParentDatainitialStates());

  static GetParentDataCubit get(context) => BlocProvider.of(context);
  GetLoggedParentData? Cur_Parent;

  void getParentData() {
    emit(GetParentDataLoadingStates());

    Diohelper.getData(
      url: ApiConstants
          .GetParentData, // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print(value.data);
      Cur_Parent = GetLoggedParentData.fromJson(value.data);
      emit(GetParentDataSuccsessStates());
    }).catchError((error) {
      print('Error fetching doctors list: $error');
      emit(GetParentDataFailedStates());
    });
  }
}
