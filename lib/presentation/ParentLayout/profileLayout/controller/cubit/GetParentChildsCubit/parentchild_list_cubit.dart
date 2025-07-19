import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentLayout/profileLayout/Model/ParentChildsModel.dart';
import 'package:asdsmartcare/presentation/ParentLayout/profileLayout/controller/cubit/GetParentData/parent_data_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/profileLayout/controller/cubit/GetParentChildsCubit/parentchild_list_state.dart';
import 'package:asdsmartcare/presentation/SignUp/Model/AddParent.dart';
import 'package:asdsmartcare/presentation/login/model/LoginDoctorModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentChildsListCubit extends Cubit<ParentChildsListStates> {
  ParentChildsListCubit() : super(GetParentChildsListinitialStates());
  
  
  static ParentChildsListCubit get(context) => BlocProvider.of(context); 
var ChildNametextcontroller = TextEditingController();
  var ChildAgetextcontroller = TextEditingController();
  var ChildGendertextcontroller = TextEditingController();

  List<Widget> ParentChilds=[  ];
  var addParentFormKey=GlobalKey<FormState>();
  
  ParentChildsModel? children;

  Future<void> getParentChildsList(String id) async{
    emit(GetParentChildsListLoadingStates());

    Diohelper.getData(
      url: ApiConstants.GetParentChildsList(id), // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
     
       print(value.data);
       children=ParentChildsModel.fromJson(value.data);
      emit(GetParentChildsListSuccsessStates());
    }).catchError((error) {
      print("Error fetching doctors list: $error");
      emit(GetParentChildsListFailedStates());
    });
  }
  
  
Future<void> addChild({required String parentId}) async {
  final url = ApiConstants.addChild(parentId);

  emit(AddChildLoadingStates());
print (ChildNametextcontroller.text+" "+ChildGendertextcontroller.text+ " "+"${ int.parse(ChildAgetextcontroller.text)}");
  try {
    final response = await Diohelper.PostData(
      url: url,
      data: {
        "childName": ChildNametextcontroller.text,
        "birthday": "2/7/2034",
        "gender": ChildGendertextcontroller.text,
        // parse to int if desired, or leave as String if your API expects a string
        "age": int.parse(ChildAgetextcontroller.text),
      },
      token: CacheHelper.getData(key: "token"),
    );

    final data = response.data as Map<String, dynamic>;

    // Handle API-level validation errors
    if (data['errors'] != null) {
      final errors = data['errors'] as List<dynamic>;
      final msg = errors.map((e) => e['msg'] as String).join('\n');
      emit(addChildFailedStates());
      return;
    }

    // Success: parse and emit
    final childResponse = ChildResponse.fromJson(data);
    print(data);
    emit(addChildSuccsessStates());
  } on DioError catch (err) {
    String msg;
    final errData = err.response?.data;
    if (errData is Map<String, dynamic> && errData['errors'] != null) {
      final errors = errData['errors'] as List<dynamic>;
      msg = errors.map((e) => e['msg'] as String).join('\n');
    } else {
      msg = err.message ?? 'Unexpected error';
    }
    print(msg);
    emit(addChildFailedStates());
  }
}


  Future<void> DeleteParentChild(String id) async{
    emit(DeleteChildLoadingStates());

    Diohelper.DeleteData(
      data: {},

      url: ApiConstants.DeleteSpacificChild(id), // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
     
       print(value.data);
      emit(DeleteChildSuccsessStates());
    }).catchError((error) {
      print("  $error");
      emit(DeleteChildFailedStates());
    });
  }
  
  
}

