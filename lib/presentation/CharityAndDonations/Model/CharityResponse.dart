class CharityResponse {
  final int? results;
  final PaginationResult? pagination;
  final List<Charity>? data;

  CharityResponse({this.results, this.pagination, this.data});

  factory CharityResponse.fromJson(Map<String, dynamic> json) {
    return CharityResponse(
      results: json['results'] as int?,
      pagination: json['pagenationResult'] != null
          ? PaginationResult.fromJson(json['pagenationResult'] as Map<String, dynamic>)
          : null,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Charity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (results != null) 'results': results,
      if (pagination != null) 'pagenationResult': pagination!.toJson(),
      if (data != null) 'data': data!.map((e) => e.toJson()).toList(),
    };
  }
}

class PaginationResult {
  final int? currentPage;
  final int? limit;
  final int? numOfPage;

  PaginationResult({this.currentPage, this.limit, this.numOfPage});

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

class Charity {
  final String? id;
  final String? charityName;
  final String? charityAddress;
  final String? charityPhone;
  final List<CharityMedicine>? charityMedican;
  final String? logo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Charity({
    this.id,
    this.charityName,
    this.charityAddress,
    this.charityPhone,
    this.charityMedican,
    this.logo,
    this.createdAt,
    this.updatedAt,
  });

  factory Charity.fromJson(Map<String, dynamic> json) {
    return Charity(
      id: json['_id'] as String?,
      charityName: json['charity_name'] as String?,
      charityAddress: json['charity_address'] as String?,
      charityPhone: json['charity_phone'] as String?,
      charityMedican: (json['charity_medican'] as List<dynamic>?)
          ?.map((e) => CharityMedicine.fromJson(e as Map<String, dynamic>))
          .toList(),
      logo: json['logo'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (charityName != null) 'charity_name': charityName,
      if (charityAddress != null) 'charity_address': charityAddress,
      if (charityPhone != null) 'charity_phone': charityPhone,
      if (charityMedican != null)
        'charity_medican': charityMedican!.map((e) => e.toJson()).toList(),
      if (logo != null) 'logo': logo,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}

class CharityMedicine {
  final String? id;
  final String? medicanName;
  final String? medicanInfo;
  final String? medicanImage;
  final Pharmacy? pharmacy;

  CharityMedicine({
    this.id,
    this.medicanName,
    this.medicanInfo,
    this.medicanImage,
    this.pharmacy,
  });

  factory CharityMedicine.fromJson(Map<String, dynamic> json) {
    return CharityMedicine(
      id: json['_id'] as String?,
      medicanName: json['medican_name'] as String?,
      medicanInfo: json['medican_info'] as String?,
      medicanImage: json['medican_image'] as String?,
      pharmacy: json['pharmacy'] != null
          ? Pharmacy.fromJson(json['pharmacy'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (medicanName != null) 'medican_name': medicanName,
      if (medicanInfo != null) 'medican_info': medicanInfo,
      if (medicanImage != null) 'medican_image': medicanImage,
      if (pharmacy != null) 'pharmacy': pharmacy!.toJson(),
    };
  }
}

class Pharmacy {
  final String? id;
  final String? pName;
  final String? pLocation;
  final String? pPhone;

  Pharmacy({this.id, this.pName, this.pLocation, this.pPhone});

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['_id'] as String?,
      pName: json['p_name'] as String?,
      pLocation: json['p_location'] as String?,
      pPhone: json['p_phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (pName != null) 'p_name': pName,
      if (pLocation != null) 'p_location': pLocation,
      if (pPhone != null) 'p_phone': pPhone,
    };
  }
}
