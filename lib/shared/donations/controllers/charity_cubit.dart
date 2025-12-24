import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/shared/donations/controllers/charity_state.dart';
import 'package:asdsmartcare/shared/donations/models/charity_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableCharityCubit extends Cubit<AvailableCharityState> {
  AvailableCharityCubit() : super(GetAvailableCharityStateInitial());

  late CharityResponse availableCharityList;

  // 1) Use a strongly-typed list:
  List<Charity> items = [];

  static AvailableCharityCubit get(BuildContext context) =>
      BlocProvider.of(context);

  void getAvailableCharity() {
    emit(GetAvailableCharityLoading());

    Diohelper.getData(
      url: ApiConstants.GetAvailableCharity,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      availableCharityList = CharityResponse.fromJson(value.data);

      // 2) Populate your items list:
      items = availableCharityList.data ?? [];

      emit(GetAvailableCharitySuccess(availableCharityList));
    }).catchError((error) {
      emit(GetAvailableCharityError('Failed to load Charitys'));
    });
  }

  void searchCharity(String medName) async {
    emit(GetAvailableCharityLoading());

    try {
      final response = await Diohelper.getData(
        url: ApiConstants.GetAvailableCharity,
        token: CacheHelper.getData(key: 'token'),
        // <-- add this:
        query: {
          'keyword': medName,
        },
      );

      availableCharityList = CharityResponse.fromJson(response.data);
      items = availableCharityList.data ?? [];

      emit(GetAvailableCharitySuccess(availableCharityList));
    } catch (error) {
      emit(GetAvailableCharityError('Failed to load Charitys'));
    }
  }
}
