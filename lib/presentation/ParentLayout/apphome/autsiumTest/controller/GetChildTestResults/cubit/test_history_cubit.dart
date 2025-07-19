import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/Home/RigesteredChild/cubit/registered_children_state.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/Home/RigesteredChild/model/registeredChildern.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/autsiumTest/controller/GetChildTestResults/cubit/test_history_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/autsiumTest/model/HistoryAustisumLevelTest.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/autsiumTest/model/HistoryAutisumTest.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestHistoryCubit extends Cubit<GetTestHistoryStates> {
  TestHistoryCubit() : super(GetTestHistoryinitialStates());
  
  HistoryAutisumTest ?His_autisumTest;
  HistoryAustisumLevelTest ?His_autisumLevelTest;

  static TestHistoryCubit get(context) => BlocProvider.of(context); 
  void GetAutismTestHistory() {
    emit(GetAutisumTestHistoryLoadingStates());

    Diohelper.getData(
      url: ApiConstants.GetAutismTestHistory, // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
     
       print(value.data);
      His_autisumTest=HistoryAutisumTest.fromJson(value.data);
      emit(GetAutisumTestHistorySuccsessStates());
    }).catchError((error) {
      print("Error fetching RegisteredChildren list: $error");
      emit(GetAutisumTestHistoryFailedStates());
    });
  }



  void GetAutismLevelTestHistory() {
    emit(GetAutisumLevelTestHistoryLoadingStates());

    Diohelper.getData(
      url: ApiConstants.GetAutismLevelTestHistory, // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
     
       print(value.data);
       His_autisumLevelTest=HistoryAustisumLevelTest.fromJson(value.data);
      
      emit(GetAutisumLevelTestHistorySuccsessStates());
    }).catchError((error) {
      print("Error fetching RegisteredChildren list: $error");
      emit(GetAutisumLevelTestHistoryFailedStates());
    });
  }




}

