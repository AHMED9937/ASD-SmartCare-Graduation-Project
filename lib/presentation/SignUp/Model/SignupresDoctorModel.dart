// models/doctor_response_model.dart

class SignupResDoctorModel {
  final DoctorModel data;
  final String token;

  SignupResDoctorModel({
    required this.data,
    required this.token,
  });

  factory SignupResDoctorModel.fromJson(Map<String, dynamic> json) {
    return SignupResDoctorModel(
      data: DoctorModel.fromJson(json['data']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
        'token': token,
      };
}

class DoctorModel {
  final String parent;
  final String speciailization;
  final String qualifications;
  final String medicalLicense;
  final int sessionPrice;
  final List<dynamic> availableDays;
  final int ratingQuantity;
  final String id;
  final String createdAt;
  final String updatedAt;
  final int v;

  DoctorModel({
    required this.parent,
    required this.speciailization,
    required this.qualifications,
    required this.medicalLicense,
    required this.sessionPrice,
    required this.availableDays,
    required this.ratingQuantity,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      parent: json['parent'] as String,
      speciailization: json['speciailization'] as String,
      qualifications: json['qualifications'] as String,
      medicalLicense: json['medicalLicense'] as String,
      sessionPrice: json['Session_price'] as int,
      availableDays:
          (json['availableDays'] as List<dynamic>?) ?? <dynamic>[],
      ratingQuantity: json['ratingQuantity'] as int,
      id: (json['_id'] ?? json['id']) as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'parent': parent,
        'speciailization': speciailization,
        'qualifications': qualifications,
        'medicalLicense': medicalLicense,
        'Session_price': sessionPrice,
        'availableDays': availableDays,
        'ratingQuantity': ratingQuantity,
        '_id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
        'id': id,
      };
}
