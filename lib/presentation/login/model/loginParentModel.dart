import 'package:asdsmartcare/presentation/login/model/loginModel.dart';
import 'package:flutter/rendering.dart';

class LoginParentmodel extends LoginUserModel {
  final ParentData Pdata;
  final String token;

  LoginParentmodel({
    required this.Pdata,
    required this.token,
  });

  factory LoginParentmodel.fromJson(Map<String, dynamic> json) {
    return LoginParentmodel(
      Pdata: ParentData.fromJson(json['data']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": Pdata.toJson(),
        "token": token,
      };
}

class ParentData {
  String id;
  ParentUserData user;
  String childName;
  String birthday;
  String gender;
  String address;
  String createdAt;
  String updatedAt;
  String v;

  ParentData({
    required this.id,
    required this.user,
    required this.address,
    required this.birthday,
    required this.childName,
    required this.createdAt,
    required this.gender,
    required this.updatedAt,
    required this.v,
  });

  factory ParentData.fromJson(Map<String, dynamic> json) {
    return ParentData(
      id: json['_id'],
      user: ParentUserData.fromJson(json['user']),
      address: json['address'],
      birthday: json['birthday'],
      childName: json['childName'],
      createdAt: json['createdAt'],
      gender: json['gender'],
      updatedAt: json['updatedAt'],
      v: json['__v'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user.toJson(),
        "address": address,
        "birthday": birthday,
        "childName": childName,
        "createdAt": createdAt,
        "gender": gender,
        "updatedAt": updatedAt,
        "__v": v,
      };
}

class ParentUserData {
  String id;
  String userName;
  String email;
  String role;

  ParentUserData({
    required this.id,
    required this.userName,
    required this.email,
    required this.role,
  });

  factory ParentUserData.fromJson(Map<String, dynamic> json) {
    return ParentUserData(
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
