import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/DoctorSessions/cubit/doctor_sessions_state.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/DoctorSessions/model/DoctorSessions.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/cubit/sessionReviews/session_reviews_state.dart';
import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorSesstionListCubit extends Cubit<GetDoctorSesstionListStates> {
  DoctorSesstionListCubit() : super(GetDoctorSesstionListinitialStates());
  
  
  static DoctorSesstionListCubit get(context) => BlocProvider.of(context); 
  SessionsResponse ?Sessions;
  void getDoctorSesstionList({required String status}) {
    emit(GetDoctorSesstionListLoadingStates());

    Diohelper.getData(
      url: ApiConstants.GetDoctorSesstionList(status), // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
     
       print(value.data);
       Sessions=SessionsResponse.fromJson(value.data);
      
      emit(GetDoctorSesstionListSuccsessStates());
    }).catchError((error) {
      print("Error fetching DoctorSesstion list: $error");
      emit(GetDoctorSesstionListFailedStates());
    });
  }
}

