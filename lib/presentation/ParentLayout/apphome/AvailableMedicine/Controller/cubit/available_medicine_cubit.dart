import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/AvailableMedicine/Controller/cubit/available_medicine_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/AvailableMedicine/model/MedicinesResponse.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AvailableMedicineCubit extends Cubit<AvailableMedicineState> {
  AvailableMedicineCubit() : super(GetAvailableMedicineStateInitial());

  late MedicineResponse AvailableMedicineList;

  // 1) Use a strongly-typed list:
  List<MedicineData> items = [];

  static AvailableMedicineCubit get(context) => BlocProvider.of(context);

  void getAvailableMedicine() {
    emit(GetAvailableMedicineLoading());

    Diohelper.getData(
      url: ApiConstants.GetAvailableMedicine,
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      print(value.data);
      AvailableMedicineList = MedicineResponse.fromJson(value.data);

      // 2) Populate your items list:
      items = AvailableMedicineList.data;

      emit(GetAvailableMedicineSuccess(AvailableMedicineList));
    }).catchError((error) {
      print("Error fetching medicine list: $error");
      emit(GetAvailableMedicineError("Failed to load medicines"));
    });
  }
void searchMedicine(String medName) async {
  emit(GetAvailableMedicineLoading());

  try {
    final response = await Diohelper.getData(
      url: ApiConstants.GetAvailableMedicine,
      token: CacheHelper.getData(key: "token"),
      // <-- add this:
      query: {
        'keyword': medName,
      },
    );

    print(response.data);
    AvailableMedicineList = MedicineResponse.fromJson(response.data);
    items = AvailableMedicineList.data;

    emit(GetAvailableMedicineSuccess(AvailableMedicineList));
  } catch (error) {
    print("Error fetching medicine list: $error");
    emit(GetAvailableMedicineError("Failed to load medicines"));
  }
}
}
