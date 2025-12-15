import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/features/doctors/controllers/doctors_list_state.dart';
import 'package:asdsmartcare/features/doctors/models/get_doctors_list_model.dart';
import 'package:asdsmartcare/features/education/controllers/education_state.dart';
import 'package:asdsmartcare/features/education/models/education_article_response.dart';
import 'package:asdsmartcare/features/auth/models/login_doctor_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AvailableEducationArticaleCubit extends Cubit<AvailableEducationArticaleState> {
  AvailableEducationArticaleCubit() : super(GetAvailableEducationArticaleStateInitial());

  late EducationArticaleModel AvailableEducationArticaleList;

  // 1) Use a strongly-typed list:
  List<Data> items = [];

  static AvailableEducationArticaleCubit get(context) => BlocProvider.of(context);

  void getAvailableEducationArticale() {
    emit(GetAvailableEducationArticaleLoading());

    Diohelper.getData(
      url: ApiConstants.GetAvailableEducationArticale,
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      print(value.data);
      AvailableEducationArticaleList = EducationArticaleModel.fromJson(value.data);

      // 2) Populate your items list:
      items = AvailableEducationArticaleList.data??[];

      emit(GetAvailableEducationArticaleSuccess(AvailableEducationArticaleList));
    }).catchError((error) {
      print("Error fetching EducationArticale list: $error");
      emit(GetAvailableEducationArticaleError("Failed to load EducationArticales"));
    });
  }
void searchEducationArticale(String medName) async {
  emit(GetAvailableEducationArticaleLoading());

  try {
    final response = await Diohelper.getData(
      url: ApiConstants.GetAvailableEducationArticale,
      token: CacheHelper.getData(key: "token"),
      // <-- add this:
      query: 
      {
        'keyword': medName,
      },
    );

    print(response.data);
    AvailableEducationArticaleList = EducationArticaleModel.fromJson(response.data);
    items = AvailableEducationArticaleList.data??[];

    emit(GetAvailableEducationArticaleSuccess(AvailableEducationArticaleList));
  } catch (error) {
    print("Error fetching EducationArticale list: $error");
    emit(GetAvailableEducationArticaleError("Failed to load EducationArticales"));
  }
}
}








