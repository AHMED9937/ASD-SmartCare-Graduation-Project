/// Model classes for parsing parent sign-up response without json_serializable
/// Example JSON:
/// {
///   "parent": {
///     "userName": "Khaled_Elmorse",
///     "email": "...",
///     ...
///   },
///   "token": "..."
/// }

import 'dart:convert';

/// Response model for parent sign-up, matching the server's JSON structure.
class SignupParentResponseModel {
  /// Parent data mapped from the JSON key "parent".
  final SignupParentData data;
  
  /// JWT token returned upon successful sign-up.
  final String token;

  SignupParentResponseModel({
    required this.data,
    required this.token,
  });

  /// Creates an instance from a JSON map.
  factory SignupParentResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupParentResponseModel(
      data: SignupParentData.fromJson(json['parent'] as Map<String, dynamic>),
      token: json['token'] as String,
    );
  }

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'parent': data.toJson(),
      'token': token,
    };
  }

  /// Parses a raw JSON string into an instance.
  factory SignupParentResponseModel.fromRawJson(String str) =>
      SignupParentResponseModel.fromJson(json.decode(str) as Map<String, dynamic>);

  /// Converts this instance to a raw JSON string.
  String toRawJson() => json.encode(toJson());
}

/// Detailed information about the signed-up parent.
class SignupParentData {
  final String userName;
  final String email;
  final String password;
  final int age;
  final String phone;
  final String address;
  final bool active;
  final String role;
  final int numOfChild;

  /// MongoDB document ID.
  final String sId;

  final DateTime createdAt;
  final DateTime updatedAt;

  /// Record version (Mongoose __v).
  final int v;

  final String emailResetCode;
  final DateTime emailResetExpire;
  final bool emailResetVerfied;

  /// Redundant string ID field.
  final String id;

  SignupParentData({
    required this.userName,
    required this.email,
    required this.password,
    required this.age,
    required this.phone,
    required this.address,
    required this.active,
    required this.role,
    required this.numOfChild,
    required this.sId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.emailResetCode,
    required this.emailResetExpire,
    required this.emailResetVerfied,
    required this.id,
  });

  /// Creates an instance from a JSON map.
  factory SignupParentData.fromJson(Map<String, dynamic> json) {
    return SignupParentData(
      userName: json['userName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      age: json['age'] as int,
      phone: json['phone'] as String,
      address: json['address'] as String,
      active: json['active'] as bool,
      role: json['role'] as String,
      numOfChild: json['numOfChild'] as int,
      sId: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
      emailResetCode: json['emailResetCode'] as String,
      emailResetExpire: DateTime.parse(json['emailResetExpire'] as String),
      emailResetVerfied: json['emailResetVerfied'] as bool,
      id: json['id'] as String,
    );
  }

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'password': password,
      'age': age,
      'phone': phone,
      'address': address,
      'active': active,
      'role': role,
      'numOfChild': numOfChild,
      '_id': sId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'emailResetCode': emailResetCode,
      'emailResetExpire': emailResetExpire.toIso8601String(),
      'emailResetVerfied': emailResetVerfied,
      'id': id,
    };
  }
}
