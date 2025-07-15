import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/Doctor/DoctorProfile/cubit/doctor_profile_data_state.dart';
import 'package:asdsmartcare/presentation/Doctor/DoctorProfile/model/GetLoggedDoctorData.dart';
import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
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

