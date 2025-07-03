class SessionReviews {
  int? results;
  PagenationResult? pagenationResult;
  List<SesstionReview>? data;

  SessionReviews({this.results, this.pagenationResult, this.data});

  SessionReviews.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    pagenationResult = json['pagenationResult'] != null
        ? new PagenationResult.fromJson(json['pagenationResult'])
        : null;
    if (json['data'] != null) {
      data = <SesstionReview>[];
      json['data'].forEach((v) {
        data!.add(new SesstionReview.fromJson(v));
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

class SesstionReview {
  String? sId;
  int? ratings;
  String? title;
  Parent? parent;
  String? doctor;
  String? createdAt;
  String? updatedAt;

  SesstionReview(
      {this.sId,
      this.ratings,
      this.title,
      this.parent,
      this.doctor,
      this.createdAt,
      this.updatedAt});

  SesstionReview.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ratings = json['ratings'];
    title = json['title'];
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
    doctor = json['doctor'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['ratings'] = this.ratings;
    data['title'] = this.title;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    data['doctor'] = this.doctor;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Parent {
  String? sId;
  String? userName;
  String? email;
  String? role;
  String? id;

  Parent({this.sId, this.userName, this.email, this.role, this.id});

  Parent.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    role = json['role'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['role'] = this.role;
    data['id'] = this.id;
    return data;
  }
}