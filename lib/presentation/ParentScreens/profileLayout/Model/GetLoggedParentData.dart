import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Model/GetSessionReviewsList.dart';

class GetLoggedParentData {
  Parent? data;

  GetLoggedParentData({this.data});

  GetLoggedParentData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Parent.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Parent {
  String? sId;
  String? userName;
  String? email;
  String? password;
  int? age;
  String? phone;
  String? address;
  bool? active;
  String? role;
  int? numOfChild;
  String? createdAt;
  String? updatedAt;
  String? sessionId;
  int? iV;
  String? emailResetCode;
  String? emailResetExpire;
  bool? emailResetVerfied;
  String? image;
  List<Childs>? childs;
  String? id;

  Parent(
      {this.sId,
      this.userName,
      this.email,
      this.password,
      this.age,
      this.phone,
      this.address,
      this.active,
      this.role,
      this.numOfChild,
      this.createdAt,
      this.updatedAt,
      this.sessionId,
      this.iV,
      this.emailResetCode,
      this.emailResetExpire,
      this.emailResetVerfied,
      this.image,
      this.childs,
      this.id});

  Parent.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    age = json['age'];
    phone = json['phone'];
    address = json['address'];
    active = json['active'];
    role = json['role'];
    numOfChild = json['numOfChild'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    sessionId = json['session_id'];
    iV = json['__v'];
    emailResetCode = json['emailResetCode'];
    emailResetExpire = json['emailResetExpire'];
    emailResetVerfied = json['emailResetVerfied'];
    image = json['image'];
    if (json['childs'] != null) {
      childs = <Childs>[];
      json['childs'].forEach((v) {
        childs!.add(new Childs.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['age'] = this.age;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['active'] = this.active;
    data['role'] = this.role;
    data['numOfChild'] = this.numOfChild;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['session_id'] = this.sessionId;
    data['__v'] = this.iV;
    data['emailResetCode'] = this.emailResetCode;
    data['emailResetExpire'] = this.emailResetExpire;
    data['emailResetVerfied'] = this.emailResetVerfied;
    data['image'] = this.image;
    if (this.childs != null) {
      data['childs'] = this.childs!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Childs {
  String? sId;
  String? childName;
  String? age;
  String? gender;

  Childs({this.sId, this.childName, this.age, this.gender});

  Childs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    childName = json['childName'];
    age = json['age'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['childName'] = this.childName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    return data;
  }
}