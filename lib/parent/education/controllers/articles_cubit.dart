import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/parent/education/controllers/articles_state.dart';
import 'package:asdsmartcare/parent/education/models/article_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableEducationArticaleCubit
    extends Cubit<AvailableEducationArticaleState> {
  AvailableEducationArticaleCubit()
      : super(GetAvailableEducationArticaleStateInitial());

  late EducationArticaleModel AvailableEducationArticaleList;

  // 1) Use a strongly-typed list:
  List<Data> items = [];

  static AvailableEducationArticaleCubit get(context) =>
      BlocProvider.of(context);

  void getAvailableEducationArticale() {
    emit(GetAvailableEducationArticaleLoading());

    final token = CacheHelper.getData(key: 'token');
    Diohelper.getData(
      url: ApiConstants.GetAvailableEducationArticale,
      token: token,
    ).then((value) {
      AvailableEducationArticaleList =
          EducationArticaleModel.fromJson(value.data);

      // 2) Populate your items list:
      items = AvailableEducationArticaleList.data ?? [];

      emit(
          GetAvailableEducationArticaleSuccess(AvailableEducationArticaleList));
    }).catchError((error) {
      emit(GetAvailableEducationArticaleError(
          'Failed to load EducationArticales'));
    });
  }

  void searchEducationArticale(String medName) async {
    emit(GetAvailableEducationArticaleLoading());

    try {
      final response = await Diohelper.getData(
        url: ApiConstants.GetAvailableEducationArticale,
        token: CacheHelper.getData(key: 'token'),
        // <-- add this:
        query: {
          'keyword': medName,
        },
      );

      AvailableEducationArticaleList =
          EducationArticaleModel.fromJson(response.data);
      items = AvailableEducationArticaleList.data ?? [];

      emit(
          GetAvailableEducationArticaleSuccess(AvailableEducationArticaleList));
    } catch (error) {
      emit(GetAvailableEducationArticaleError(
          'Failed to load EducationArticales'));
    }
  }
}
