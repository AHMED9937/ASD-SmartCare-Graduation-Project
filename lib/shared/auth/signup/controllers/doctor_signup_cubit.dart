import 'dart:typed_data';

import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/shared/auth/signup/models/doctor_signup_request.dart';
import 'package:asdsmartcare/shared/auth/signup/models/doctor_signup_response.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/doctor_signup_state.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
  Uint8List? fileBytes; // For web support
  FilePickerResult? myfile;

  late ReqSignupDoctorModel ReqsignupDoctorModel;
  late SignupResDoctorModel doctorSignupResponse;

  // Method to pick the medical license file (e.g. a PDF)
  Future<void> pickMedicalLicenseFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true, // Important for web - loads file bytes
    );
    if (result != null && result.files.single.name.isNotEmpty) {
      fileP = result.files.single.path; // Will be null on web
      fileN = result.files.single.name;
      fileBytes = result.files.single.bytes; // Use bytes for web
      myfile = result;
      medicalLicenseTextController.text = fileN!;
      emit(DoctorSignUpInitialState()); // Refresh UI
    }
  }

  Future<void> doctorSignUp() async {
    final token = CacheHelper.getData(key: 'token');
    if (token == null) {
      emit(DoctorSignUpErrorState('No token found'));
      return;
    }

    // Check for file - on web use bytes, on mobile use path
    if (kIsWeb) {
      if (fileBytes == null) {
        emit(DoctorSignUpErrorState('Please upload medical license PDF'));
        return;
      }
    } else {
      if (fileP == null) {
        emit(DoctorSignUpErrorState('Please upload medical license PDF'));
        return;
      }
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

    // Build multipart form data - handle web vs mobile
    MultipartFile medicalLicenseFile;
    if (kIsWeb) {
      medicalLicenseFile = MultipartFile.fromBytes(
        fileBytes!,
        filename: fileN,
      );
    } else {
      medicalLicenseFile = await MultipartFile.fromFile(
        fileP!,
        filename: fileN,
      );
    }

    final formData = FormData.fromMap({
      'speciailization': ReqsignupDoctorModel.specialization,
      'qualifications': ReqsignupDoctorModel.qualifications,
      'medicalLicense': medicalLicenseFile,
      'address': ReqsignupDoctorModel.address,
      'Session_price': ReqsignupDoctorModel.sessionPrice,
    });

    try {
      final Response response = await Diohelper.postData(
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
