import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/signupCubits/Model/SignupreqDoctorModel.dart';
import 'package:asdsmartcare/presentation/signupCubits/Model/SignupresDoctorModel.dart';
import 'package:asdsmartcare/presentation/signupCubits/cubit/DoctorCubit/doctor_state.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
class DoctorSignUpCubit extends Cubit<DoctorSignUpState> {
  DoctorSignUpCubit() : super(DoctorSignUpInitialState());

  static DoctorSignUpCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final specializationController = TextEditingController();
  final qualificationsController = TextEditingController();
  final medicalLicenseTextController = TextEditingController();
  final clinicAddressController = TextEditingController();
  // final sessionPriceController = TextEditingController(); // Not used in this code

  // Stored file for the medical license
  late MultipartFile storedMedicalLicenseFile;
  late var fileP;
  late var fileN;
  late var myfile;

  late ReqSignupDoctorModel ReqsignupDoctorModel;
  late DoctorSignupResponse doctorSignupResponse;

  // Method to pick the medical license file (e.g. a PDF)
  Future<void> pickMedicalLicenseFile() async {
   FilePickerResult? result = await FilePicker.platform.pickFiles(
  type: FileType.custom,
  allowedExtensions: ['pdf'],
);
    if (result != null) {
      final filePath = result.files.single.path;
      if (filePath != null) {
        fileP = filePath;
        fileN = result.files.single.name;
        myfile = result;

        medicalLicenseTextController.text = result.files.single.name;
      }
    }
  }

  Future<void> doctorSignUp() async {
    final token = CacheHelper.getData(key: "token");
    if (token == null) {
      emit(DoctorSignUpErrorState("No token found"));
      return;
    }

    emit(DoctorSignUpLoadingState());

    // Create a SignupDoctorModel instance with the provided form data.
    // Note: sessionPrice is set to "100" here.
    ReqsignupDoctorModel = ReqSignupDoctorModel(
      specialization: specializationController.text,
      qualifications: qualificationsController.text,
      // This holds the file name (for reference) and the file itself is passed below
      medicalLicense: medicalLicenseTextController.text,
      address: clinicAddressController.text,
      sessionPrice: "100",
    );

    // print("${signupDoctorModel.address} ${signupDoctorModel.medicalLicense} ${signupDoctorModel.qualifications} ${signupDoctorModel.sessionPrice}");

    // Convert the model to FormData for a multipart/form-data request
    print(fileP);
    print(myfile != null);
    final formData = FormData.fromMap({
      'specialization': ReqsignupDoctorModel.specialization,
      'qualifications': ReqsignupDoctorModel.qualifications,
      'medicalLicense': await MultipartFile.fromFile(
  fileP!,
  filename: fileN,
),
      'address': ReqsignupDoctorModel.address,
      'Session_price': "100",
    });
print(formData.fields);
  var file = formData.files.first.value;
  print("Filename: ${file.filename}");
  print("Content Type: ${file.contentType}");
    Diohelper.PostData(
      url: ApiConstants.singupForDoctor,
      data: formData,
      token: token,
    ).then((value) {
      print("Response data type: ${value.data.runtimeType}");
      print("Response data: ${value.data}");
      if (value.statusCode == 200 || value.statusCode == 201) {
        doctorSignupResponse = DoctorSignupResponse.fromJson(value.data);
        emit(DoctorSignUpSuccessState());
      } else {
        emit(DoctorSignUpErrorState("Server Error: ${value.statusCode}"));
      }
    }).catchError((onError) {
      if (onError is DioException) {
        if (onError.response != null) {
          print("Dio error response: ${onError.response?.data["message"]}");
          emit(DoctorSignUpErrorState("${onError.response?.data["message"]}"));
        } else {
          print("Dio error message: ${onError.message}");
          emit(DoctorSignUpErrorState("Network error: ${onError.message}"));
        }
      } else {
        print("General error: ${onError.toString()}");
        emit(DoctorSignUpErrorState("Unexpected error occurred"));
      }
    });
  }
}
