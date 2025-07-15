import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/CharityAndDonations/Controller/cubit/charity_state.dart';
import 'package:asdsmartcare/presentation/CharityAndDonations/Model/CharityResponse.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AvailableCharityCubit extends Cubit<AvailableCharityState> {
  AvailableCharityCubit() : super(GetAvailableCharityStateInitial());

  late CharityResponse AvailableCharityList;

  // 1) Use a strongly-typed list:
  List<Charity> items = [];

  static AvailableCharityCubit get(context) => BlocProvider.of(context);

  void getAvailableCharity() {
    emit(GetAvailableCharityLoading());

    Diohelper.getData(
      url: ApiConstants.GetAvailableCharity,
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      print(value.data);
      AvailableCharityList = CharityResponse.fromJson(value.data);

      // 2) Populate your items list:
      items = AvailableCharityList.data??[];

      emit(GetAvailableCharitySuccess(AvailableCharityList));
    }).catchError((error) {
      print("Error fetching Charity list: $error");
      emit(GetAvailableCharityError("Failed to load Charitys"));
    });
  }
void searchCharity(String medName) async {
  emit(GetAvailableCharityLoading());

  try {
    final response = await Diohelper.getData(
      url: ApiConstants.GetAvailableCharity,
      token: CacheHelper.getData(key: "token"),
      // <-- add this:
      query: {
        'keyword': medName,
      },
    );

    print(response.data);
    AvailableCharityList = CharityResponse.fromJson(response.data);
    items = AvailableCharityList.data??[];

    emit(GetAvailableCharitySuccess(AvailableCharityList));
  } catch (error) {
    print("Error fetching Charity list: $error");
    emit(GetAvailableCharityError("Failed to load Charitys"));
  }
}
}
