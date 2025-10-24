import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/parent/account/controllers/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit() : super(ChangePasswordInitialStates());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  final obscureCurrent = ValueNotifier<bool>(true);
  final obscureNew = ValueNotifier<bool>(true);
  final obscureConfirm = ValueNotifier<bool>(true);

  void changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
    required bool isParent,
  }) {
    emit(ChangePasswordLoadingStates());

    Diohelper.putData(
      url: isParent
          ? ApiConstants.updateLoggedInParentPassword
          : ApiConstants.updateLoggedInDoctorPassword,
      token: CacheHelper.getData(key: 'token'),
      data: {
        'currentPassword': currentPassword,
        'password': newPassword,
        'confirmPassword': confirmPassword,
      },
    ).then((value) {
      debugPrint(value.data.toString());
      emit(ChangePasswordSuccessStates());
    }).catchError((error) {
      debugPrint('Error changing password: $error');
      emit(ChangePasswordFailedStates());
    });
  }
}
