import 'dart:io';
import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/SignUp/Model/SignupreqDoctorModel.dart';
import 'package:asdsmartcare/presentation/SignUp/Model/SignupresDoctorModel.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/DoctorCubit/doctor_state.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorSignUpCubit extends Cubit<DoctorSignUpState> {
  DoctorSignUpCubit() : super(DoctorSignUpInitialState());

  static DoctorSignUpCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final specializationController = TextEditingController();
  final qualificationsController = TextEditingController();
  final medicalLicenseTextController = TextEditingController();
  final clinicAddressController = TextEditingController();

  // Stored file paths and picker result
  String? fileP;
  String? fileN;
  FilePickerResult? myfile;

  late ReqSignupDoctorModel ReqsignupDoctorModel;
  late SignupResDoctorModel doctorSignupResponse;

  // Method to pick the medical license file (e.g. a PDF)
  Future<void> pickMedicalLicenseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      fileP = result.files.single.path;
      fileN = result.files.single.name;
      myfile = result;
      medicalLicenseTextController.text = fileN!;
    }
  }

  Future<void> doctorSignUp() async {
    final token = CacheHelper.getData(key: "token");
    if (token == null) {
      emit(DoctorSignUpErrorState("No token found"));
      return;
    }

    if (fileP == null) {
      emit(DoctorSignUpErrorState("Please upload medical license PDF"));
      return;
    }

    emit(DoctorSignUpLoadingState());

    // Create a request model
    ReqsignupDoctorModel = ReqSignupDoctorModel(
      specialization: specializationController.text,
      qualifications: qualificationsController.text,
      medicalLicense: medicalLicenseTextController.text,
      address: clinicAddressController.text,
      sessionPrice: 100.0,
    );

    // Build multipart form data
    final formData = FormData.fromMap({
      'speciailization': ReqsignupDoctorModel.specialization,
      'qualifications': ReqsignupDoctorModel.qualifications,
      'medicalLicense': await MultipartFile.fromFile(
        fileP!,
        filename: fileN,
      ),
      'address': ReqsignupDoctorModel.address,
      'Session_price': ReqsignupDoctorModel.sessionPrice,
    });

    try {
      Response response = await Diohelper.PostData(
        url: ApiConstants.singupForDoctor,
        data: formData,
        token: token,
      );
      doctorSignupResponse = SignupResDoctorModel.fromJson(response.data);
      print(response.data);
      emit(DoctorSignUpSuccessState());
    } catch (error) {
      emit(DoctorSignUpErrorState(error.toString()));
    }
  }
}
