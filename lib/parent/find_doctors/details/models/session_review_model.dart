import 'package:asdsmartcare/core/models/pagination_result.dart';

class SessionReviews {
  int? results;
  PaginationResult? paginationResult;
  List<SessionReview>? data;

  SessionReviews({this.results, this.paginationResult, this.data});

  SessionReviews.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    paginationResult = json['pagenationResult'] != null
        ? PaginationResult.fromJson(json['pagenationResult'])
        : null;
    if (json['data'] != null) {
      data = <SessionReview>[];
      json['data'].forEach((v) {
        data!.add(SessionReview.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (paginationResult != null) {
      data['pagenationResult'] = paginationResult!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SessionReview {
  String? sId;
  int? ratings;
  String? title;
  Parent? parent;
  String? doctor;
  String? createdAt;
  String? updatedAt;

  SessionReview({
    this.sId,
    this.ratings,
    this.title,
    this.parent,
    this.doctor,
    this.createdAt,
    this.updatedAt,
  });

  SessionReview.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ratings = json['ratings'];
    title = json['title'];
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
    doctor = json['doctor'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['ratings'] = ratings;
    data['title'] = title;
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    data['doctor'] = doctor;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['email'] = email;
    data['role'] = role;
    data['id'] = id;
    return data;
  }
}
