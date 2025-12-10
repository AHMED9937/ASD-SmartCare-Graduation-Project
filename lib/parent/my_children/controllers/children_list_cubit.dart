import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/parent/my_children/models/child_model.dart';
import 'package:asdsmartcare/parent/my_children/controllers/children_list_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentChildrenListCubit extends Cubit<ParentChildrenListStates> {
  ParentChildrenListCubit() : super(ParentChildrenListInitialStates());

  static ParentChildrenListCubit get(context) => BlocProvider.of(context);

  final childNameController = TextEditingController();
  final childAgeController = TextEditingController();
  final childGenderController = TextEditingController();

  List<Widget> parentChildren = [];
  final addParentFormKey = GlobalKey<FormState>();

  ParentChildsModel? children;

  Future<void> getParentChildrenList(String id) async {
    emit(GetParentChildrenListLoadingStates());

    Diohelper.getData(
          url: ApiConstants.getParentChildrenList(id),
          token: CacheHelper.getData(key: 'token'),
        )
        .then((value) {
          debugPrint(
            'Loaded ${(value.data as Map)['data']?.length ?? 0} children',
          );
          children = ParentChildsModel.fromJson(value.data);
          emit(GetParentChildrenListSuccessStates());
        })
        .catchError((error) {
          debugPrint('Error fetching children list: $error');
          emit(GetParentChildrenListFailedStates());
        });
  }

  Future<void> addChild({required String parentId}) async {
    final url = ApiConstants.addChild(parentId);

    emit(AddChildLoadingStates());
    debugPrint('Adding child: ${childNameController.text}');
    try {
      final response = await Diohelper.postData(
        url: url,
        data: {
          'childName': childNameController.text,
          'birthday': '2/7/2034',
          'gender': childGenderController.text,
          'age': int.tryParse(childAgeController.text) ?? 5,
        },
        token: CacheHelper.getData(key: 'token'),
      );

      final data = response.data as Map<String, dynamic>;

      if (data['errors'] != null) {
        emit(AddChildFailedStates());
        return;
      }

      debugPrint('Child added successfully');
      emit(AddChildSuccessStates());
    } on DioException catch (err) {
      String msg;
      final errData = err.response?.data;
      if (errData is Map<String, dynamic> && errData['errors'] != null) {
        final errors = errData['errors'] as List<dynamic>;
        msg = errors.map((e) => e['msg'] as String).join('\n');
      } else {
        msg = err.message ?? 'Unexpected error';
      }
      debugPrint('Add child error: $msg');
      emit(AddChildFailedStates());
    }
  }

  Future<void> deleteParentChild(String id) async {
    emit(DeleteChildLoadingStates());

    Diohelper.deleteData(
          query: {},
          url: ApiConstants.deleteSpecificChild(id),
          token: CacheHelper.getData(key: 'token'),
        )
        .then((value) {
          debugPrint('Child deleted successfully');
          emit(DeleteChildSuccessStates());
        })
        .catchError((error) {
          debugPrint('Error deleting child: $error');
          emit(DeleteChildFailedStates());
        });
  }
}
