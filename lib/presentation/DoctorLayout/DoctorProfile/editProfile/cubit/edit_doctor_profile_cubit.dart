import 'dart:io';
import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/Doctor/DoctorProfile/editProfile/cubit/edit_doctor_profile_state.dart';
import 'package:asdsmartcare/presentation/Doctor/DoctorProfile/model/GetLoggedDoctorData.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';  // for MediaType

// Alias DioMediaType for compatibility
typedef DioMediaType = MediaType;

class EditDoctorProfileCubit extends Cubit<EditDoctorProfileState> {
  EditDoctorProfileCubit() : super(EditDoctorProfileInitialState());

  static EditDoctorProfileCubit get(context) => BlocProvider.of(context);

  GetLoggedDoctorData? newDoctorData;
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameCtrl;
  late TextEditingController DepartmentCtrl;
  late TextEditingController qualificationsCtrl;
  late TextEditingController SessionPriceCtrl;
  //late TextEditingController phoneCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController ageCtrl;
  late TextEditingController addressCtrl;

  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  void initFrom(GetLoggedDoctorData Doctor) {
    final d = Doctor.data!;
    nameCtrl          = TextEditingController(text: d.parent!.userName);
    DepartmentCtrl    = TextEditingController(text: d.speciailization);
    qualificationsCtrl = TextEditingController(text: d.qualifications);
    SessionPriceCtrl  = TextEditingController(text: d.sessionPrice.toString());
    emailCtrl         = TextEditingController(text: d.parent!.email);
    ageCtrl           = TextEditingController(text: d.parent!.age?.toString());
    addressCtrl       = TextEditingController(text: d.parent!.address);
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
      emit(EditDoctorProfilePhotoPicked());
    }
  }

  Future<void> editDoctorProfile() async {
    emit(EditDoctorProfileLoadingState());

    final token = CacheHelper.getData(key: 'token');
    if (token == null) {
      emit(EditDoctorProfileErrorState('Not authenticated'));
      return;
    }

    try {
      final formData = FormData.fromMap({
        if (pickedImage != null)
          'image': await MultipartFile.fromFile(
            pickedImage!.path,
            filename: pickedImage!.path.split(Platform.pathSeparator).last,
            contentType: DioMediaType('image', 'jpeg'),
          ),
        'userName': nameCtrl.text,
        'speciailization': DepartmentCtrl.text,
        'qualifications': qualificationsCtrl.text,
        'Session_price': SessionPriceCtrl.text,
        'email': emailCtrl.text,
        'age': ageCtrl.text,
        'address': addressCtrl.text,
      });

      final res = await Diohelper.PutData(
        url: ApiConstants.updateDoctorProfile,
        data: formData,
        token: token,
      );

      if (res.statusCode == 200) {
        newDoctorData = GetLoggedDoctorData.fromJson(res.data);
        emit(EditDoctorProfileSuccessState());
      } else {
        final msg = res.data is Map<String, dynamic>
            ? res.data['message'] ?? 'Unknown error'
            : res.statusMessage ?? 'Unknown error';
        emit(EditDoctorProfileErrorState(msg));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.response?.data is Map<String, dynamic>) {
        final data = e.response!.data as Map<String, dynamic>;
        errorMsg = data['message'] ?? e.message;
      } else {
        errorMsg = e.toString();
      }
      emit(EditDoctorProfileErrorState(errorMsg));
    } catch (e) {
      emit(EditDoctorProfileErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    nameCtrl.dispose();
    DepartmentCtrl.dispose();
    qualificationsCtrl.dispose();
    SessionPriceCtrl.dispose();
    emailCtrl.dispose();
    ageCtrl.dispose();
    addressCtrl.dispose();
    return super.close();
  }
}
