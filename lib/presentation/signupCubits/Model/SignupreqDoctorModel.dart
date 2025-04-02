import 'package:dio/dio.dart';

class ReqSignupDoctorModel {
  final String specialization;
  final String qualifications;
  final String medicalLicense; // File name or identifier
  final String address;
  final String sessionPrice;
  final MultipartFile? medicalLicenseFile; // Stored file from earlier

  ReqSignupDoctorModel({
    required this.specialization,
    required this.qualifications,
    required this.medicalLicense,
    required this.address,
    required this.sessionPrice,
    this.medicalLicenseFile,
  });

  factory ReqSignupDoctorModel.fromJson(Map<String, dynamic> json) {
    return ReqSignupDoctorModel(
      specialization: json['specialization'] ?? '',
      qualifications: json['qualifications'] ?? '',
      medicalLicense: json['medicalLicense'] ?? '',
      address: json['address'] ?? '',
      sessionPrice: json['Session_price'] ?? '',
      // Note: We don't parse the file from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'specialization': specialization,
      'qualifications': qualifications,
      'medicalLicense': medicalLicense,
      'address': address,
      'Session_price': sessionPrice,
      // Exclude medicalLicenseFile as it is not JSON serializable
    };
  }

  // Convert the model to FormData for a multipart/form-data request.
  FormData toFormData() {
    return FormData.fromMap({
      'specialization': specialization,
      'qualifications': qualifications,
      'medicalLicense': medicalLicenseFile ,
      'address': address,
      'Session_price': sessionPrice,
      'medicalLicense': medicalLicense ,

      
      // If the stored file is available, attach it; otherwise, send the file name.
    });
  }
}
