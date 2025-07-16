import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/Model/GetLoggedParentData.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/controller/cubit/GetParentData/parent_data_state.dart';
import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetParentDataCubit extends Cubit<GetParentDataStates> {
  GetParentDataCubit() : super(GetParentDatainitialStates());
  
  
  static GetParentDataCubit get(context) => BlocProvider.of(context); 
   GetLoggedParentData? Cur_Parent;

  void getParentData() {
    emit(GetParentDataLoadingStates());

    Diohelper.getData(
      url: ApiConstants.GetParentData, // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
     
       print(value.data);
      Cur_Parent=GetLoggedParentData.fromJson(value.data);
      emit(GetParentDataSuccsessStates());
    }).catchError((error) {
      print("Error fetching doctors list: $error");
      emit(GetParentDataFailedStates());
    });
  }
}

