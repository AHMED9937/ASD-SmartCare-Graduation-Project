import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/features/doctors/views/doctors_list_screen.dart';
import 'package:asdsmartcare/features/app_start/controllers/asd_state.dart';
import 'package:asdsmartcare/features/education/views/articles.dart';
import 'package:asdsmartcare/features/autism_test/views/ai_evaluation.dart';
import 'package:asdsmartcare/features/progress/views/progress.dart';
import 'package:asdsmartcare/features/profile/views/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsdCubit extends Cubit<AsdStates> {
  AsdCubit():super(AsdInitialState());

  static AsdCubit get(context)=>BlocProvider.of(context);
  int current_index=0;
  
         List ParentBottomNavgation= [
            Articles(),
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



