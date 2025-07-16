import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/Model/GetLoggedParentData.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/controller/cubit/ChangePassword/cubit/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChanagePasswordCubit extends Cubit<ChanagePasswordStates> {
  ChanagePasswordCubit() : super(ChanagePasswordinitialStates());

  static ChanagePasswordCubit get(context) => BlocProvider.of(context);


  final formKey = GlobalKey<FormState>();
  final currentController = TextEditingController();
  final newController     = TextEditingController();
  final confirmController = TextEditingController();

  // we can still keep these as final ValueNotifiers in a StatelessWidget
  final obscureCurrent = ValueNotifier<bool>(true);
  final obscureNew     = ValueNotifier<bool>(true);
  final obscureConfirm = ValueNotifier<bool>(true);

  /// Now takes the three password fields
  void changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
    required bool IsParent,
  }) {
    emit(ChanagePasswordLoadingStates());

    Diohelper.PutData(
      url:IsParent? ApiConstants.UpdateLogedParentPassword:ApiConstants.UpdateLogedDoctorPassword,
      token: CacheHelper.getData(key: "token"),
      data: {
        "currentPassword": currentPassword,
        "password":       newPassword,
        "confirmPassword": confirmPassword,
      },
    ).then((value) {
      print(value.data);
      emit(ChanagePasswordSuccsessStates());
    }).catchError((error) {
      print("Error changing password: $error");
      emit(ChanagePasswordFailedStates());
    });
  }
}
