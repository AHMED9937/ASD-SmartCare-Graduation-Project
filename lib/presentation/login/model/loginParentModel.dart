class LoginParentModel {
  ParentData? data;
  String? token;

  LoginParentModel({this.data, this.token});

  LoginParentModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ParentData.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class ParentData {
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
  String? passwordChangedAt;
  List<Childs>? childs;
  String? id;

  ParentData(
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
      this.passwordChangedAt,
      this.childs,
      this.id});

  ParentData.fromJson(Map<String, dynamic> json) {
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
    passwordChangedAt = json['passwordChangedAt'];
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
    data['passwordChangedAt'] = this.passwordChangedAt;
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