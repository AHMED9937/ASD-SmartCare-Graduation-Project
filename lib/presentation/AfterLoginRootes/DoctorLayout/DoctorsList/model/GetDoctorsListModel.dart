class DoctorListResponse {
  final int results;
  final PaginationResult pagenationResult;
  final List<DoctorModel> data;

  DoctorListResponse({
    required this.results,
    required this.pagenationResult,
    required this.data,
  });

  factory DoctorListResponse.fromJson(Map<String, dynamic> json) {
    return DoctorListResponse(
      results: json["results"],
      pagenationResult: PaginationResult.fromJson(json["pagenationResult"]),
      data: (json["data"] as List)
          .map((item) => DoctorModel.fromJson(item))
          .toList(),
    );
  }
}

class PaginationResult {
  final int currentPage;
  final int limit;
  final int numOfPage;

  PaginationResult({
    required this.currentPage,
    required this.limit,
    required this.numOfPage,
  });

  factory PaginationResult.fromJson(Map<String, dynamic> json) {
    return PaginationResult(
      currentPage: json["currentPage"],
      limit: json["limit"],
      numOfPage: json["numOfPage"],
    );
  }
}

class DoctorModel {
  final String id; // Maps to _id (or "id" if provided)
  final DoctorUser? user;
  final String specialization; // JSON key "speciailization"
  final String qualifications;
  final String medicalLicense;
  final String address;
  final int sessionPrice;
  final List<dynamic> availableDays;
  final int ratingQuantity;
  final DateTime createdAt;
  final DateTime updatedAt;

  DoctorModel({
    required this.id,
    required this.user,
    required this.specialization,
    required this.qualifications,
    required this.medicalLicense,
    required this.address,
    required this.sessionPrice,
    required this.availableDays,
    required this.ratingQuantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json["_id"] ?? json["id"],
      user: json["user"] != null ? DoctorUser.fromJson(json["user"]) : null,
      specialization: json["speciailization"] ?? "",
      qualifications: json["qualifications"] ?? "",
      medicalLicense: json["medicalLicense"] ?? "",
      address: json["address"] ?? "",
      sessionPrice: json["Session_price"] is int
          ? json["Session_price"]
          : int.tryParse(json["Session_price"].toString()) ?? 0,
      availableDays: json["availableDays"] ?? [],
      ratingQuantity: json["ratingQuantity"] ?? 0,
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }
}

class DoctorUser {
  final String id; // Maps to _id
  final String userName;
  final String email;
  final String role;

  DoctorUser({
    required this.id,
    required this.userName,
    required this.email,
    required this.role,
  });

  factory DoctorUser.fromJson(Map<String, dynamic> json) {
    return DoctorUser(
      id: json["_id"] ?? "",
      userName: json["userName"] ?? "",
      email: json["email"] ?? "",
      role: json["role"] ?? "",
    );
  }
}
