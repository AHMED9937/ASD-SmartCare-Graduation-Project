import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/features/doctors/controllers/doctors_list_state.dart';
import 'package:asdsmartcare/features/doctors/models/get_doctors_list_model.dart';
import 'package:asdsmartcare/features/auth/models/login_doctor_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsListCubit extends Cubit<GetDoctorsListStates> {
  DoctorsListCubit() : super(GetDoctorsListinitialStates());
  
   DoctorList? DoctorListRes;
   List<Doctor>myDoctorList=[];
  
  static DoctorsListCubit get(context) => BlocProvider.of(context); 
    final List<Map<String, String>> doctors = [];
    Doctor ?SelectedDoctor;

  void getDoctorsList({bool RecomededDoctor=false}) {
    emit(GetDoctorsListLoadingStates());

    Diohelper.getData(
      url: ApiConstants.GetDoctorsList, // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
       query:RecomededDoctor? {"sort":"-ratingsAverage"}:null
    ).then((value) {
     
      DoctorListRes = DoctorList.fromJson(value.data);
myDoctorList=DoctorListRes!.data??[];
       print(value.data);
      //print(myDoctorList.data[0]);
      emit(GetDoctorsListSuccsessStates());
    }).catchError((error) {
      print("Error fetching doctors list: $error");
      emit(GetDoctorsListFailedStates());
    });
  }

  
  void SearchDoctorsList({String ?ByName,bool ?byRating}) {
    emit(GetDoctorsListLoadingStates());

    Diohelper.getData(
      url: ApiConstants.GetDoctorsList, // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
      query: {"keyword":ByName,"sort":"-ratingsAverage"}
    ).then((value) {
     
      DoctorListRes = DoctorList.fromJson(value.data);
myDoctorList=DoctorListRes!.data??[];
       print(value.data);
      //print(myDoctorList.data[0]);
      emit(GetDoctorsListSuccsessStates());
    }).catchError((error) {
      print("Error fetching doctors list: $error");
      emit(GetDoctorsListFailedStates());
    });
  }

}






