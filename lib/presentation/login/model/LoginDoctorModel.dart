class LoginDoctorModel {
  final DoctorData? data;
  final String? token;

  LoginDoctorModel({this.data, this.token});

  factory LoginDoctorModel.fromJson(Map<String, dynamic> json) {
    return LoginDoctorModel(
      data: json['data'] != null ? DoctorData.fromJson(json['data']) : null,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (data != null) {
      result['data'] = data!.toJson();
    }
    if (token != null) {
      result['token'] = token;
    }
    return result;
  }
}

class DoctorData {
  final String? id;
  final Parent? parent;
  final String? specialization;
  final String? qualifications;
  final String? medicalLicense;
  final int? sessionPrice;
  final List<dynamic>? availableDays;
  final int? ratingQuantity;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? image;
  final int? ratingsAverage;

  DoctorData({
    this.id,
    this.parent,
    this.specialization,
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

  factory DoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorData(
      id: json['id'] as String? ?? json['_id'] as String?,
      parent: json['parent'] != null ? Parent.fromJson(json['parent']) : null,
      specialization: json['specialization'] as String?,
      qualifications: json['qualifications'] as String?,
      medicalLicense: json['medicalLicense'] as String?,
      sessionPrice: json['Session_price'] as int?,
      availableDays: json['availableDays'] != null
          ? List<dynamic>.from(json['availableDays'])
          : null,
      ratingQuantity: json['ratingQuantity'] as int?,
      role: json['role'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      v: json['__v'] as int?,
      image: json['image'] as String?,
      ratingsAverage: json['ratingsAverage'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['_id'] = id;
    if (parent != null) {
      result['parent'] = parent!.toJson();
    }
    result['specialization'] = specialization;
    result['qualifications'] = qualifications;
    result['medicalLicense'] = medicalLicense;
    result['Session_price'] = sessionPrice;
    if (availableDays != null) {
      result['availableDays'] = availableDays;
    }
    result['ratingQuantity'] = ratingQuantity;
    result['role'] = role;
    result['createdAt'] = createdAt?.toIso8601String();
    result['updatedAt'] = updatedAt?.toIso8601String();
    result['__v'] = v;
    result['image'] = image;
    result['ratingsAverage'] = ratingsAverage;
    result['id'] = id;
    return result;
  }
}

class Parent {
  final String? id;
  final String? userName;
  final String? email;
  final List<dynamic>? childs;

  Parent({this.id, this.userName, this.email, this.childs});

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['id'] as String? ?? json['_id'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      childs: json['childs'] != null
          ? List<dynamic>.from(json['childs'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['_id'] = id;
    result['userName'] = userName;
    result['email'] = email;
    if (childs != null) {
      result['childs'] = childs;
    }
    result['id'] = id;
    return result;
  }
}