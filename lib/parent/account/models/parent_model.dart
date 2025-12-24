class GetLoggedParentData {
  Parent? data;

  GetLoggedParentData({this.data});

  GetLoggedParentData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Parent.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
        childs!.add(Childs.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['email'] = email;
    data['password'] = password;
    data['age'] = age;
    data['phone'] = phone;
    data['address'] = address;
    data['active'] = active;
    data['role'] = role;
    data['numOfChild'] = numOfChild;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['session_id'] = sessionId;
    data['__v'] = iV;
    data['emailResetCode'] = emailResetCode;
    data['emailResetExpire'] = emailResetExpire;
    data['emailResetVerfied'] = emailResetVerfied;
    data['image'] = image;
    if (childs != null) {
      data['childs'] = childs!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['childName'] = childName;
    data['age'] = age;
    data['gender'] = gender;
    return data;
  }
}
