// lib/models/doctor_list.dart

class DoctorList {
  final int? results;
  final PaginationResult? pagination;
  final List<Doctor>? data;

  DoctorList({
    this.results,
    this.pagination,
    this.data,
  });

  factory DoctorList.fromJson(Map<String, dynamic> json) {
    return DoctorList(
      results: json['results'] as int?,
      pagination: json['pagenationResult'] != null
          ? PaginationResult.fromJson(json['pagenationResult'])
          : null,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Doctor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (results != null) 'results': results,
      if (pagination != null) 'pagenationResult': pagination!.toJson(),
      if (data != null) 'data': data!.map((d) => d.toJson()).toList(),
    };
  }
}

class PaginationResult {
  final int? currentPage;
  final int? limit;
  final int? numOfPage;

  PaginationResult({
    this.currentPage,
    this.limit,
    this.numOfPage,
  });

  factory PaginationResult.fromJson(Map<String, dynamic> json) {
    return PaginationResult(
      currentPage: json['currentPage'] as int?,
      limit: json['limit'] as int?,
      numOfPage: json['numOfPage'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (currentPage != null) 'currentPage': currentPage,
      if (limit != null) 'limit': limit,
      if (numOfPage != null) 'numOfPage': numOfPage,
    };
  }
}

class Doctor {
  final String? id;
  final Parent? parent;
  final String? speciailization;
  final String? qualifications;
  final String? medicalLicense;
  final int? sessionPrice;
  final List<String>? availableDays;   // e.g. ["Monday","Tuesday"] or day-IDs
  final int? ratingQuantity;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? image;
  final int? ratingsAverage;

  Doctor({
    this.id,
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
    this.image,
    this.ratingsAverage,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'] as String?,
      parent: json['parent'] != null
          ? Parent.fromJson(json['parent'] as Map<String, dynamic>)
          : null,
      speciailization: json['speciailization'] as String?,
      qualifications: json['qualifications'] as String?,
      medicalLicense: json['medicalLicense'] as String?,
      sessionPrice: json['Session_price'] as int?,
      availableDays: (json['availableDays'] as List<dynamic>?)
          ?.map((d) => d as String)
          .toList(),
      ratingQuantity: json['ratingQuantity'] as int?,
      role: json['role'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      image: json['image'] as String?,
      ratingsAverage: json['ratingsAverage'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (parent != null) 'parent': parent!.toJson(),
      if (speciailization != null) 'speciailization': speciailization,
      if (qualifications != null) 'qualifications': qualifications,
      if (medicalLicense != null) 'medicalLicense': medicalLicense,
      if (sessionPrice != null) 'Session_price': sessionPrice,
      if (availableDays != null) 'availableDays': availableDays,
      if (ratingQuantity != null) 'ratingQuantity': ratingQuantity,
      if (role != null) 'role': role,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      if (image != null) 'image': image,
      if (ratingsAverage != null) 'ratingsAverage': ratingsAverage,
    };
  }
}

class Parent {
  final String? id;
  final String? userName;
  final String? email;
  final int? age;
  final String? phone;
  final String? address;
  final List<String>? childIds;   // list of child document IDs

  Parent({
    this.id,
    this.userName,
    this.email,
    this.age,
    this.phone,
    this.address,
    this.childIds,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['_id'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      age: json['age'] as int?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      childIds: (json['childs'] as List<dynamic>?)
          ?.map((c) => c as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userName != null) 'userName': userName,
      if (email != null) 'email': email,
      if (age != null) 'age': age,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (childIds != null) 'childs': childIds,
    };
  }
}
