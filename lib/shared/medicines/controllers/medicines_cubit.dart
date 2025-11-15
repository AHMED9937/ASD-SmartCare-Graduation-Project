import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/shared/medicines/controllers/medicines_state.dart';
import 'package:asdsmartcare/shared/medicines/models/medicine_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableMedicineCubit extends Cubit<AvailableMedicineState> {
  AvailableMedicineCubit() : super(GetAvailableMedicineStateInitial());

  late MedicineResponse availableMedicineList;

  // 1) Use a strongly-typed list:
  List<MedicineData> items = [];

  static AvailableMedicineCubit get(context) => BlocProvider.of(context);

  void getAvailableMedicine() {
    emit(GetAvailableMedicineLoading());

    Diohelper.getData(
      url: ApiConstants.getAvailableMedicine,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      availableMedicineList = MedicineResponse.fromJson(value.data);
      items = availableMedicineList.data;
      emit(GetAvailableMedicineSuccess(availableMedicineList));
    }).catchError((error) {
      emit(GetAvailableMedicineError('Failed to load medicines'));
    });
  }

  void searchMedicine(String medName) async {
    emit(GetAvailableMedicineLoading());

    try {
      final response = await Diohelper.getData(
        url: ApiConstants.getAvailableMedicine,
        token: CacheHelper.getData(key: 'token'),
        // <-- add this:
        query: {
          'keyword': medName,
        },
      );

      availableMedicineList = MedicineResponse.fromJson(response.data);
      items = availableMedicineList.data;

      emit(GetAvailableMedicineSuccess(availableMedicineList));
    } catch (error) {
      emit(GetAvailableMedicineError('Failed to load medicines'));
    }
  }
}
