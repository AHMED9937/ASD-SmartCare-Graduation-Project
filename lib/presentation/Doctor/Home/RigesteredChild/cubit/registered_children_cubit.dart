import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/RigesteredChild/cubit/registered_children_state.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/RigesteredChild/model/registeredChildern.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisteredChildrenListCubit extends Cubit<GetRegisteredChildrenListStates> {
  RegisteredChildrenListCubit() : super(GetRegisteredChildrenListinitialStates());
  
  
  static RegisteredChildrenListCubit get(context) => BlocProvider.of(context); 
  RegisteredChildren ?registeredchildren;
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
}

