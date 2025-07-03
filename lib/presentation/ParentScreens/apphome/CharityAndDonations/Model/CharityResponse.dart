class CharityResponse {
  int? results;
  PagenationResult? pagenationResult;
  List<Charity>? data;

  CharityResponse({this.results, this.pagenationResult, this.data});

  CharityResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    pagenationResult = json['pagenationResult'] != null
        ? new PagenationResult.fromJson(json['pagenationResult'])
        : null;
    if (json['data'] != null) {
      data = <Charity>[];
      json['data'].forEach((v) {
        data!.add(new Charity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.pagenationResult != null) {
      data['pagenationResult'] = this.pagenationResult!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PagenationResult {
  int? currentPage;
  int? limit;
  int? numOfPage;

  PagenationResult({this.currentPage, this.limit, this.numOfPage});

  PagenationResult.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    limit = json['limit'];
    numOfPage = json['numOfPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['limit'] = this.limit;
    data['numOfPage'] = this.numOfPage;
    return data;
  }
}

class Charity {
  String? sId;
  String? charityName;
  String? charityAddress;
  String? charityPhone;
  List<CharityMedican>? charityMedican;
  String? logo;
  String? createdAt;
  String? updatedAt;

  Charity(
      {this.sId,
      this.charityName,
      this.charityAddress,
      this.charityPhone,
      this.charityMedican,
      this.logo,
      this.createdAt,
      this.updatedAt});

  Charity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    charityName = json['charity_name'];
    charityAddress = json['charity_address'];
    charityPhone = json['charity_phone'];
    if (json['charity_medican'] != null) {
      charityMedican = <CharityMedican>[];
      json['charity_medican'].forEach((v) {
        charityMedican!.add(new CharityMedican.fromJson(v));
      });
    }
    logo = json['logo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['charity_name'] = this.charityName;
    data['charity_address'] = this.charityAddress;
    data['charity_phone'] = this.charityPhone;
    if (this.charityMedican != null) {
      data['charity_medican'] =
          this.charityMedican!.map((v) => v.toJson()).toList();
    }
    data['logo'] = this.logo;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class CharityMedican {
  String? sId;
  String? medicanName;
  String? medicanInfo;
  String? medicanImage;
  Pharmacy? pharmacy;

  CharityMedican(
      {this.sId,
      this.medicanName,
      this.medicanInfo,
      this.medicanImage,
      this.pharmacy});

  CharityMedican.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    medicanName = json['medican_name'];
    medicanInfo = json['medican_info'];
    medicanImage = json['medican_image'];
    pharmacy = json['pharmacy'] != null
        ? new Pharmacy.fromJson(json['pharmacy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['medican_name'] = this.medicanName;
    data['medican_info'] = this.medicanInfo;
    data['medican_image'] = this.medicanImage;
    if (this.pharmacy != null) {
      data['pharmacy'] = this.pharmacy!.toJson();
    }
    return data;
  }
}

class Pharmacy {
  String? sId;
  String? pName;
  String? pLocation;
  String? pPhone;

  Pharmacy({this.sId, this.pName, this.pLocation, this.pPhone});

  Pharmacy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    pName = json['p_name'];
    pLocation = json['p_location'];
    pPhone = json['p_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['p_name'] = this.pName;
    data['p_location'] = this.pLocation;
    data['p_phone'] = this.pPhone;
    return data;
  }
}