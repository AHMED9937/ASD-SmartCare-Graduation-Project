import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorsList/cubit/doctors_list_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorsList/model/GetDoctorsListModel.dart';
import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
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


