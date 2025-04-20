import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/AfterLoginRootes/DoctorLayout/DoctorsList/cubit/doctors_list_state.dart';
import 'package:asdsmartcare/presentation/AfterLoginRootes/DoctorLayout/DoctorsList/model/GetDoctorsListModel.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsListCubit extends Cubit<GetDoctorsListStates> {
  DoctorsListCubit() : super(GetDoctorsListinitialStates());
  
  late DoctorListResponse myDoctorList;
  
  static DoctorsListCubit get(context) => BlocProvider.of(context); 
    final List<Map<String, String>> doctors = [
    {
      "name": "Dr. Ahmed Mahmoud",
      "specialty": "Speech-Language Pathologist",
      "image": "lib/appassets/images/doctor1.png",
    },
    {
      "name": "Dr. Omnia Mustafa",
      "specialty": "Speech-Language Pathologist",
      "image": "lib/appassets/images/doctor2.png",
    },
    {
      "name": "Dr. Muhammad Ahmed",
      "specialty": "Speech-Language Pathologist",
      "image": "lib/appassets/images/doctor3.png",
    },
    {
      "name": "Dr. Samir Faisal",
      "specialty": "Speech-Language Pathologist",
      "image": "lib/appassets/images/doctor4.png",
    }
  ];
  DoctorModel ?SelectedDoctor;

  void getDoctorsList() {
    emit(GetDoctorsListLoadingStates());

    Diohelper.getData(
      url: ApiConstants.GetDoctorsList, // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {

      myDoctorList = DoctorListResponse.fromJson(value.data);
      print(myDoctorList.data[0].qualifications);
      emit(GetDoctorsListSuccsessStates());
    }).catchError((error) {
      print("Error fetching doctors list: $error");
      emit(GetDoctorsListFailedStates());
    });
  }
}

