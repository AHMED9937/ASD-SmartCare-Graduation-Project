class DoctorSignupResponse {
  final String? user;
  // Notice the JSON actually says "speciailization"
  final String? specialization;
  final String? qualifications;
  final String? medicalLicense;  // just a URL string
  final String? address;
  final int? sessionPrice;
  final List<dynamic>? availableDays;
  final int? ratingQuantity;
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final String? token;

  DoctorSignupResponse({
    this.user,
    this.specialization,
    this.qualifications,
    this.medicalLicense,
    this.address,
    this.sessionPrice,
    this.availableDays,
    this.ratingQuantity,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.token,
  });

  factory DoctorSignupResponse.fromJson(Map<String, dynamic> json) {
    // "data" is a Map, "token" is a String at the root
    final data = json['data'] as Map<String, dynamic>?;

    return DoctorSignupResponse(
      user: data?['user'] as String?,
      // Key is spelled "speciailization" in your JSON
      specialization: data?['speciailization'] as String?,
      qualifications: data?['qualifications'] as String?,
      medicalLicense: data?['medicalLicense'] as String?, 
      address: data?['address'] as String?,
      // Key is "Session_price" in your JSON
      sessionPrice: data?['Session_price'] as int?,
      // "availableDays" is a List
      availableDays: data?['availableDays'] as List<dynamic>?,
      ratingQuantity: data?['ratingQuantity'] as int?,
      id: data?['_id'] as String?,
      createdAt: data?['createdAt'] as String?,
      updatedAt: data?['updatedAt'] as String?,
      v: data?['__v'] as int?,
      token: json['token'] as String?,  // token is outside "data"
    );
  }
}
