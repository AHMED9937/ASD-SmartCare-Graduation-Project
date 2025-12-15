import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/features/doctors/presentation/doctors_list/screen/DoctorsListPage.dart';
import 'package:asdsmartcare/features/app_start/presentation/cubit/asd_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/appHome.dart';
import 'package:asdsmartcare/features/autism_test/presentation/Screen/AiEvaluation.dart';
import 'package:asdsmartcare/features/progress/presentation/screens/progress.dart';
import 'package:asdsmartcare/features/profile/presentation/screen/profileScreen.dart';
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