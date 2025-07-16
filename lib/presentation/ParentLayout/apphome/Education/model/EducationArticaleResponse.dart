class EducationArticaleModel {
  int? results;
  PaginationResult? paginationResult;
  List<Data>? data;

  EducationArticaleModel({this.results, this.paginationResult, this.data});

  EducationArticaleModel.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    paginationResult = json['paginationResult'] != null
        ? new PaginationResult.fromJson(json['paginationResult'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.paginationResult != null) {
      data['paginationResult'] = this.paginationResult!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaginationResult {
  int? currentPage;
  int? limit;
  int? numOfPages;

  PaginationResult({this.currentPage, this.limit, this.numOfPages});

  PaginationResult.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    limit = json['limit'];
    numOfPages = json['numOfPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['limit'] = this.limit;
    data['numOfPages'] = this.numOfPages;
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? info;
  String? image;
  String? creator;
  String? createdAt;

  Data(
      {this.sId,
      this.title,
      this.info,
      this.image,
      this.creator,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    info = json['info'];
    image = json['image'];
    creator = json['creator'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['info'] = this.info;
    data['image'] = this.image;
    data['creator'] = this.creator;
    data['createdAt'] = this.createdAt;
    return data;
  }
}