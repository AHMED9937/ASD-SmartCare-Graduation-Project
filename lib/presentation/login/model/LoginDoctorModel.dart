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
      token:json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class DoctorData {
  String id;
  DoctorUserData user;
  String speciailization;
  String qualifications;
  String medicalLicense;
  String address;
  int sessionPrice;
  List<dynamic> availableDays;
  int ratingQuantity;
  String createdAt;
  String updatedAt;
  String v;

  DoctorData({
    required this.id,
    required this.user,
    required this.speciailization,
    required this.qualifications,
    required this.medicalLicense,
    required this.address,
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
      user: DoctorUserData.fromJson(json['user']),
      speciailization: json['speciailization'],
      qualifications: json['qualifications'],
      medicalLicense: json['medicalLicense'],
      address: json['address'],
      sessionPrice: json['Session_price'],
      availableDays: json['availableDays'],
      ratingQuantity: json['ratingQuantity'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user.toJson(),
        "speciailization": speciailization,
        "qualifications": qualifications,
        "medicalLicense": medicalLicense,
        "address": address,
        "Session_price": sessionPrice,
        "availableDays": availableDays,
        "ratingQuantity": ratingQuantity,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "id": id,
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
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
        "email": email,
        "role": role,
      };
}
