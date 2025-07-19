import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorsList/cubit/doctors_list_cubit.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/controller/childProgress/child_progress_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/model/GetAllSession.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/model/ParentBookedDoctors.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


class ChildProgressCubit extends Cubit<ChildProgressState> {
  
  ChildProgressCubit() : super(ChildProgressInitial());
List<Doctors>? myDoctorList=[];
  static ChildProgressCubit get(context) => BlocProvider.of(context); 
  int current = 0;
   List<SessionData> Sessions=[];

void GetAllDoctorsBookedaSpecificParent(){


    emit(GetParentBookedDoctorsLoading());

    Diohelper.getData(
      url: ApiConstants.GetParentBookedDoctors, // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
     
      myDoctorList = ParentBookedDoctors.fromJson(value.data).doctors;
       print(value.data);
      //print(myDoctorList.data[0]);
      emit(GetParentBookedDoctorsLoaded());
    }).catchError((error) {
      print("Error fetching doctors list: $error");
      emit(GetParentBookedDoctorsError());
    });
  }


void GetAllCommingSessionsBookedaSpecificParent(String id,bool isComming){


    emit(GetAllBookedSessionsByStatusLoading());

    Diohelper.getData(
      url: ApiConstants.GetAllSessionForSpecificParentAndDoctorByStatus(id,isComming?"coming":"done"), // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
     
       print(value.data);
      Sessions=GetAllSessions.fromJson(value.data).data??[];
      emit(GetAllBookedSessionsByStatusLoaded());
    }).catchError((error) {
      print("Error fetching doctors list: $error");
      emit(GetAllBookedSessionsByStatusError());
    });
  }





}

