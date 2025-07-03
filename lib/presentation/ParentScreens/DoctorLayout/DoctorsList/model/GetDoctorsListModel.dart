// doctor_models.dart

class DoctorList {
  final int? results;
  final PaginationResult? paginationResult;
  final List<Doctor>? data;

  DoctorList({this.results, this.paginationResult, this.data});

  factory DoctorList.fromJson(Map<String, dynamic> json) => DoctorList(
        results: json['results'] as int?,
        paginationResult: json['pagenationResult'] != null
            ? PaginationResult.fromJson(json['pagenationResult'] as Map<String, dynamic>)
            : null,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Doctor.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'results': results,
        if (paginationResult != null) 'pagenationResult': paginationResult!.toJson(),
        if (data != null) 'data': data!.map((e) => e.toJson()).toList(),
      };
}

class PaginationResult {
  final int? currentPage;
  final int? limit;
  final int? numOfPage;

  PaginationResult({this.currentPage, this.limit, this.numOfPage});

  factory PaginationResult.fromJson(Map<String, dynamic> json) => PaginationResult(
        currentPage: json['currentPage'] as int?,
        limit: json['limit'] as int?,
        numOfPage: json['numOfPage'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'currentPage': currentPage,
        'limit': limit,
        'numOfPage': numOfPage,
      };
}

class Doctor {
  final String? id;
  final Parent? parent;
  final String? specialization;
  final String? qualifications;
  final String? medicalLicense;
  final int? sessionPrice;
  final List<String>? availableDays;
  final int? ratingQuantity;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? image;

  Doctor({
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
    this.image,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: (json['_id'] as String?) ?? json['id'] as String?,
        parent: json['parent'] != null
            ? Parent.fromJson(json['parent'] as Map<String, dynamic>)
            : null,
        specialization: json['speciailization'] as String?,
        qualifications: json['qualifications'] as String?,
        medicalLicense: json['medicalLicense'] as String?,
        sessionPrice: json['Session_price'] as int?,
        availableDays: (json['availableDays'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        ratingQuantity: json['ratingQuantity'] as int?,
        role: json['role'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'] as String)
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'] as String)
            : null,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        if (parent != null) 'parent': parent!.toJson(),
        'speciailization': specialization,
        'qualifications': qualifications,
        'medicalLicense': medicalLicense,
        'Session_price': sessionPrice,
        'availableDays': availableDays,
        'ratingQuantity': ratingQuantity,
        'role': role,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'id': id,
        'image': image,
      };
}

class Parent {
  final String? id;
  final String? userName;
  final String? email;

  Parent({this.id, this.userName, this.email});

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        id: (json['_id'] as String?) ?? json['id'] as String?,
        userName: json['userName'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userName': userName,
        'email': email,
        'id': id,
      };
}
