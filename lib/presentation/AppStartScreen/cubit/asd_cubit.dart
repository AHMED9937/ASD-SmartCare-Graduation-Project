import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorsList/screen/DoctorsListPage.dart';
import 'package:asdsmartcare/presentation/AppStartScreen/cubit/asd_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/appHome.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/autsiumTest/Screen/AiEvaluation.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/screens/progress.dart';
import 'package:asdsmartcare/presentation/ParentLayout/profileLayout/screen/profileScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsdCubit extends Cubit<AsdStates> {
  AsdCubit():super(AsdInitialState());

  static AsdCubit get(context)=>BlocProvider.of(context);
  int current_index=0;
  
         List ParentBottomNavgation= [
            HomePage(),
            DoctorsListPage(),
            AiEvaluationScreen(),
            ChildProgressScreen(),
            Profilescreen(),
          ];
  void Reset(){
    emit(AsdInitialState());
  }
  void change_index(int val){
    
    current_index=val;
    
    emit(AsdChangIindexState());
  }




}