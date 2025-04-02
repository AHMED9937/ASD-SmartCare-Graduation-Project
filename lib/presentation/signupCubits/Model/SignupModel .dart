import 'package:dio/dio.dart';

class SignupDoctorModel {
  final String specialization;
  final String qualifications;
  final String medicalLicense; // File name or identifier
  final String address;
  final String sessionPrice;
  final MultipartFile? medicalLicenseFile; // Previously stored file

  SignupDoctorModel({
    required this.specialization,
    required this.qualifications,
    required this.medicalLicense,
    required this.address,
    required this.sessionPrice,
    this.medicalLicenseFile,
  });

  // Create an instance from JSON (server response)
  factory SignupDoctorModel.fromJson(Map<String, dynamic> json) {
    return SignupDoctorModel(
      specialization: json['specialization'] ?? '',
      qualifications: json['qualifications'] ?? '',
      medicalLicense: json['medicalLicense'] ?? '',
      address: json['address'] ?? '',
      sessionPrice: json['Session_price'] ?? '',
      medicalLicenseFile: null, // We don't deserialize the file
    );
  }

  // Convert the model (without file) to JSON
  Map<String, dynamic> toJson() {
    return {
      'specialization': specialization,
      'qualifications': qualifications,
      'medicalLicense': medicalLicense,
      'address': address,
      'Session_price': sessionPrice,
    };
  }

  // Convert the model to FormData for a multipart request.
  // If the file exists, attach it; otherwise, send the file name.
  FormData toFormData() {
    return FormData.fromMap({
      'specialization': specialization,
      'qualifications': qualifications,
      'address': address,
      'Session_price': sessionPrice,
      'medicalLicense': medicalLicenseFile ?? medicalLicense,
    });
  }
}
