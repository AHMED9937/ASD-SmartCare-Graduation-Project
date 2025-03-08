class LoginUserModel {
  UserData? data;
  String? token;

  LoginUserModel({
    this.data,
    this.token,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "token": token,
      };
}

class UserData {
  final String id;
  final String userName;
  final String email;
  final String phone;
  final String password;
  final bool active;
  final String role;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String emailResetCode;
  final String emailResetExpire;
  final bool emailResetVerfied;

  UserData({
    required this.id,
    required this.userName,
    required this.email,
    required this.phone,
    required this.password,
    required this.active,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.emailResetCode,
    required this.emailResetExpire,
    required this.emailResetVerfied,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'],
      userName: json['userName'], // Updated key to match sample
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      active: json['active'],
      role: json['role'], // Updated to a string type if needed
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      emailResetCode: json['emailResetCode'],
      emailResetExpire: json['emailResetExpire'],
      emailResetVerfied: json['emailResetVerfied'],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName, // Consistent key naming
        "email": email,
        "phone": phone,
        "password": password,
        "active": active,
        "role": role,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "emailResetCode": emailResetCode,
        "emailResetExpire": emailResetExpire,
        "emailResetVerfied": emailResetVerfied,
      };
}
