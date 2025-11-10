class GetLoggedDoctorData {
  Doctor? data;

  GetLoggedDoctorData({this.data});

  factory GetLoggedDoctorData.fromJson(Map<String, dynamic> json) {
    return GetLoggedDoctorData(
      data: json['data'] != null ? Doctor.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class Doctor {
  String? id;
  String? sId;
  Parent? parent;
  String? speciailization;
  String? qualifications;
  String? medicalLicense;
  int? sessionPrice;
  List<dynamic>? availableDays;
  int? ratingQuantity;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? image;
  int? ratingsAverage;

  Doctor({
    this.id,
    this.sId,
    this.parent,
    this.speciailization,
    this.qualifications,
    this.medicalLicense,
    this.sessionPrice,
    this.availableDays,
    this.ratingQuantity,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.image,
    this.ratingsAverage,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      sId: json['_id'] as String?,
      id: json['id'] as String?,
      parent: json['parent'] != null
          ? Parent.fromJson(json['parent'] as Map<String, dynamic>)
          : null,
      speciailization: json['speciailization'] as String?,
      qualifications: json['qualifications'] as String?,
      medicalLicense: json['medicalLicense'] as String?,
      sessionPrice: json['Session_price'] as int?,
      availableDays: json['availableDays'] != null
          ? List<dynamic>.from(json['availableDays'] as List)
          : null,
      ratingQuantity: json['ratingQuantity'] as int?,
      role: json['role'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
      image: json['image'] as String?,
      ratingsAverage: json['ratingsAverage'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (sId != null) '_id': sId,
      if (id != null) 'id': id,
      if (parent != null) 'parent': parent!.toJson(),
      if (speciailization != null) 'speciailization': speciailization,
      if (qualifications != null) 'qualifications': qualifications,
      if (medicalLicense != null) 'medicalLicense': medicalLicense,
      if (sessionPrice != null) 'Session_price': sessionPrice,
      if (availableDays != null) 'availableDays': availableDays,
      if (ratingQuantity != null) 'ratingQuantity': ratingQuantity,
      if (role != null) 'role': role,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
      if (v != null) '__v': v,
      if (image != null) 'image': image,
      if (ratingsAverage != null) 'ratingsAverage': ratingsAverage,
    };
  }
}

class Parent {
  String? id;
  String? sId;
  String? userName;
  String? email;
  int? age;
  String? address;
  List<dynamic>? childs;

  Parent({
    this.id,
    this.sId,
    this.userName,
    this.email,
    this.age,
    this.address,
    this.childs,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      sId: json['_id'] as String?,
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      age: json['age'] as int?,
      address: json['address'] as String?,
      childs: json['childs'] != null
          ? List<dynamic>.from(json['childs'] as List)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (sId != null) '_id': sId,
      if (id != null) 'id': id,
      if (userName != null) 'userName': userName,
      if (email != null) 'email': email,
      if (age != null) 'age': age,
      if (address != null) 'address': address,
      if (childs != null) 'childs': childs,
    };
  }
}
