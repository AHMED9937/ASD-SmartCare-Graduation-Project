import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/screen/DoctorsListPage.dart';
import 'package:asdsmartcare/presentation/AsdAppLayouts/cubit/asd_state.dart';
import 'package:asdsmartcare/presentation/ParentScreens/EvaluateLayout/screens/Evaluate.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/appHome.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/Screen/AiEvaluation.dart';
import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/screens/progress.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/screen/profileScreen.dart';
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
  
  void change_index(int val){
    
    current_index=val;
    
    emit(AsdChangIindexState());
  }




}