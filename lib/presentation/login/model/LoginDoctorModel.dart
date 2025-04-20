class LoginDoctorModel {
  final DoctorData data;
  String token;

  LoginDoctorModel({
    required this.data,
    required this.token,
  });

  factory LoginDoctorModel.fromJson(Map<String, dynamic> json) {
    return LoginDoctorModel(
      data: DoctorData.fromJson(json['data']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
        'token': token,
      };
}

class DoctorData {
  String id;
  DoctorUserData parent;
  String speciailization;
  String qualifications;
  String medicalLicense;
  // address was not in your sample JSON, so it’s removed here
  int sessionPrice;
  List<dynamic> availableDays;
  int ratingQuantity;
  String createdAt;
  String updatedAt;
  String v;

  DoctorData({
    required this.id,
    required this.parent,
    required this.speciailization,
    required this.qualifications,
    required this.medicalLicense,
    required this.sessionPrice,
    required this.availableDays,
    required this.ratingQuantity,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory DoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorData(
      id: json['_id'] ?? json['id'],
      parent: DoctorUserData.fromJson(json['parent']),
      speciailization: json['speciailization'],
      qualifications: json['qualifications'],
      medicalLicense: json['medicalLicense'],
      sessionPrice: json['Session_price'],
      availableDays: json['availableDays'] ?? [],
      ratingQuantity: json['ratingQuantity'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'parent': parent.toJson(),
        'speciailization': speciailization,
        'qualifications': qualifications,
        'medicalLicense': medicalLicense,
        'Session_price': sessionPrice,
        'availableDays': availableDays,
        'ratingQuantity': ratingQuantity,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': int.tryParse(v) ?? 0,
        'id': id,
      };
}

class DoctorUserData {
  String id;
  String userName;
  String email;
  String role;

  DoctorUserData({
    required this.id,
    required this.userName,
    required this.email,
    required this.role,
  });

  factory DoctorUserData.fromJson(Map<String, dynamic> json) {
    return DoctorUserData(
      id: json['_id'] ?? json['id'],
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userName': userName,
        'email': email,
        'role': role,
      };
}
