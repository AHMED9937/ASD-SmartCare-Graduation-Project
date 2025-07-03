class MedicineResponse {
  final int results;
  final PaginationResult pagenationResult;
  final List<MedicineData> data;

  MedicineResponse({
    required this.results,
    required this.pagenationResult,
    required this.data,
  });

  factory MedicineResponse.fromJson(Map<String, dynamic> json) {
    final results = json['results'] as int? ?? 0;

    // Safely parse pagination
    final paginationRaw = json['pagenationResult'];
    final pagination = (paginationRaw is Map<String, dynamic>)
        ? PaginationResult.fromJson(paginationRaw)
        : PaginationResult(currentPage: 0, limit: 0, numOfPage: 0);

    // Safely parse list of medicines
    final dataList = json['data'];
    final items = (dataList is List)
        ? dataList
            .whereType<Map<String, dynamic>>()
            .map((e) => MedicineData.fromJson(e))
            .toList()
        : <MedicineData>[];

    return MedicineResponse(
      results: results,
      pagenationResult: pagination,
      data: items,
    );
  }

  Map<String, dynamic> toJson() => {
        'results': results,
        'pagenationResult': pagenationResult.toJson(),
        'data': data.map((m) => m.toJson()).toList(),
      };
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
      currentPage: json['currentPage'] as int? ?? 0,
      limit: json['limit'] as int? ?? 0,
      numOfPage: json['numOfPage'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'currentPage': currentPage,
        'limit': limit,
        'numOfPage': numOfPage,
      };
}

class MedicineData {
  final String id;
  final String medicanName;
  final String medicanInfo;
  final String medicanImage;
  final Pharmacy pharmacy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MedicineData({
    required this.id,
    required this.medicanName,
    required this.medicanInfo,
    required this.medicanImage,
    required this.pharmacy,
    this.createdAt,
    this.updatedAt,
  });

  factory MedicineData.fromJson(Map<String, dynamic> json) {
    // Safely parse nested pharmacy
    final pharmacyRaw = json['pharmacy'];
    final pharmacy = (pharmacyRaw is Map<String, dynamic>)
        ? Pharmacy.fromJson(pharmacyRaw)
        : Pharmacy.empty();

    return MedicineData(
      id: json['_id'] as String? ?? '',
      medicanName: json['medican_name'] as String? ?? '',
      medicanInfo: json['medican_info'] as String? ?? '',
      medicanImage: json['medican_image'] as String? ?? '',
      pharmacy: pharmacy,
      createdAt: json['createdAt'] is String
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] is String
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'medican_name': medicanName,
        'medican_info': medicanInfo,
        'medican_image': medicanImage,
        'pharmacy': pharmacy.toJson(),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

class Pharmacy {
  final String id;
  final String name;
  final String location;
  final String phone;

  Pharmacy({
    required this.id,
    required this.name,
    required this.location,
    required this.phone,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['_id'] as String? ?? '',
      name: json['p_name'] as String? ?? '',
      location: json['p_location'] as String? ?? '',
      phone: json['p_phone'] as String? ?? '',
    );
  }

  // Provides a default empty instance
  factory Pharmacy.empty() {
    return Pharmacy(id: '', name: '', location: '', phone: '');
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'p_name': name,
        'p_location': location,
        'p_phone': phone,
      };
}