import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/Home/RigesteredChild/cubit/registered_children_state.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/Home/RigesteredChild/model/registeredChildern.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisteredChildrenListCubit extends Cubit<GetRegisteredChildrenListStates> {
  RegisteredChildrenListCubit() : super(GetRegisteredChildrenListinitialStates());
  
  
  static RegisteredChildrenListCubit get(context) => BlocProvider.of(context); 
  RegisteredChildren ?registeredchildren;
    /// Call this to go back to the initial (form) state
  void reset() {
    emit(GetRegisteredChildrenListinitialStates());
  }

  void getRegisteredChildrenList() {
    emit(GetRegisteredChildrenListLoadingStates());

    Diohelper.getData(
      url: ApiConstants.GetRegisteredChildrenList, // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
     
       print(value.data);
       registeredchildren=RegisteredChildren.fromJson(value.data);
      
      emit(GetRegisteredChildrenListSuccsessStates());
    }).catchError((error) {
      print("Error fetching RegisteredChildren list: $error");
      emit(GetRegisteredChildrenListFailedStates());
    });
  }

    void CreateSession(result) {
    emit(CreatSessionLoadingStates());

    Diohelper.PostData(
      url: ApiConstants.CreateSessions,
      token: CacheHelper.getData(key: "token"),
      data:result,
    ).then((value) {
     
       print(value.data);
      
      emit(CreatSessionSuccsessStates());
    }).catchError((error) {
      print("Error fetching RegisteredChildren list: $error");
      emit(CreatSessionFailedStates());
    });
  }
  
  
}

