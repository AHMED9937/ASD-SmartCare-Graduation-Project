import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/AfterLoginRootes/Doctor/screen/DoctorsListPage.dart';
import 'package:asdsmartcare/presentation/AfterLoginRootes/AsdAppLayouts/cubit/asd_state.dart';
import 'package:asdsmartcare/presentation/AfterLoginRootes/apphome/appHome.dart';
import 'package:asdsmartcare/presentation/AfterLoginRootes/chat/screen/chatScreen.dart';
import 'package:asdsmartcare/presentation/profile/screen/profileScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsdCubit extends Cubit<AsdStates> {
  AsdCubit():super(AsdInitialState());

  static AsdCubit get(context)=>BlocProvider.of(context);
  int current_index=0;
  
         List MyAppBottomNavgation= [
            HomePage(),
            DoctorsListPage(),
            Chatscreen(),
            Profilescreen(),
          ];
  
  void change_index(int val){
    
    current_index=val;
    
    emit(AsdChangIindexState());
  }




}