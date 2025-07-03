import 'dart:io';
import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/Model/GetLoggedParentData.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/controller/cubit/EditProfile/edit_profile_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditParentProfileCubit extends Cubit<EditParentProfileState> {
  EditParentProfileCubit() : super(EditParentProfileInitialState());

  static EditParentProfileCubit get(context) => BlocProvider.of(context);

  GetLoggedParentData ? newParentData;
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController ageCtrl;
  late TextEditingController addressCtrl;

  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  void initFrom(GetLoggedParentData parent) {
    final d = parent.data!;
    nameCtrl    = TextEditingController(text: d.userName);
    phoneCtrl   = TextEditingController(text: d.phone);
    emailCtrl   = TextEditingController(text: d.email);
    ageCtrl     = TextEditingController(text: d.age?.toString());
    addressCtrl = TextEditingController(text: d.address);
  }

  Future<void> pickPhoto(ImageSource source) async {
    final file = await _picker.pickImage(
      source: source,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 85,
    );
    if (file != null) {
      pickedImage = File(file.path);
      emit(EditParentProfilePhotoPicked());
    }
  }



Future<void> editParentProfile() async {
  
  emit(EditParentProfileLoadingState());

  final token = CacheHelper.getData(key: 'token');
  if (token == null) {
    emit(EditParentProfileErrorState('Not authenticated'));
    return;
  }

  try {
    // build the multipart form just like your doctor cubit:
    final formData = FormData.fromMap({
      if (pickedImage!=null)
      "image":await MultipartFile.fromFile(
          pickedImage!.path,
          filename: pickedImage!.path.split(Platform.pathSeparator).last,
          contentType: DioMediaType("image","jpg"),
        ),
      'userName': nameCtrl.text,
      'phone':    phoneCtrl.text,
      'email':    emailCtrl.text,
      'age':      ageCtrl.text,
      'address':  addressCtrl.text,
    });

    final res = await Diohelper.PutData(
      url: ApiConstants.updateParentProfile,
      data: formData,
      token: token,
    );

    if (res.statusCode == 200) {
      newParentData = GetLoggedParentData.fromJson(res.data);
      emit(EditParentProfileSuccessState());
    } else {
      // server returned non‐200 but no exception
      final msg = res.data is Map<String, dynamic>
        ? res.data['message'] ?? 'Unknown error'
        : res.statusMessage ?? 'Unknown error';
      emit(EditParentProfileErrorState(msg));
    }
  } on DioError catch (e) {
    // catch DioErrors and pull out the JSON \"message\" if present
    String errorMsg;
    if (e.response?.data is Map<String, dynamic>) {
      final data = e.response!.data as Map<String, dynamic>;
      errorMsg = data['message'] ?? e.message;
    } else {
      errorMsg = e.toString();
    }
    emit(EditParentProfileErrorState(errorMsg));
  } catch (e) {
    // any other error
    emit(EditParentProfileErrorState(e.toString()));
  }
}
 @override
  Future<void> close() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    ageCtrl.dispose();
    addressCtrl.dispose();
    return super.close();
  }
}
