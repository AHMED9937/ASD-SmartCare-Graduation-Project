import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/features/doctor_profile/controllers/doctor_profile_data_state.dart';
import 'package:asdsmartcare/features/doctor_profile/models/get_logged_doctor_data.dart';
import 'package:asdsmartcare/features/auth/models/login_doctor_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetDoctorDataCubit extends Cubit<GetDoctorDataStates> {
  GetDoctorDataCubit() : super(GetDoctorDatainitialStates());
  
  
  static GetDoctorDataCubit get(context) => BlocProvider.of(context); 
   GetLoggedDoctorData? Cur_Doctor;

  void getDoctorData() {
    emit(GetDoctorDataLoadingStates());

    Diohelper.getData(
      url: ApiConstants.GetDoctorData, // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
     
       print(value.data);
      Cur_Doctor=GetLoggedDoctorData.fromJson(value.data);
      emit(GetDoctorDataSuccsessStates());
    }).catchError((error) {
      print("Error fetching doctors list: $error");
      emit(GetDoctorDataFailedStates());
    });
  }
}





