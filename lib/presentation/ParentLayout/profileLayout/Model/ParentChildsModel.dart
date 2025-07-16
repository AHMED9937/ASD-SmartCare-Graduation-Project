class ParentChildsModel {
  int? results;
  PagenationResult? pagenationResult;
  List<child>? childs;

  ParentChildsModel({this.results, this.pagenationResult, this.childs});

  ParentChildsModel.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    pagenationResult = json['pagenationResult'] != null
        ? new PagenationResult.fromJson(json['pagenationResult'])
        : null;
    if (json['data'] != null) {
      childs = <child>[];
      json['data'].forEach((v) {
        childs!.add(new child.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.pagenationResult != null) {
      data['pagenationResult'] = this.pagenationResult!.toJson();
    }
    if (this.childs != null) {
      data['data'] = this.childs!.map((v) => v.toJson()).toList();
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

class child {
  String? sId;
  String? parent;
  String? childName;
  String? birthday;
  String? age;
  String? gender;
  String? createdAt;
  String? updatedAt;

  child(
      {this.sId,
      this.parent,
      this.childName,
      this.birthday,
      this.age,
      this.gender,
      this.createdAt,
      this.updatedAt});

  child.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    parent = json['parent'];
    childName = json['childName'];
    birthday = json['birthday'];
    age = json['age'];
    gender = json['gender'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['parent'] = this.parent;
    data['childName'] = this.childName;
    data['birthday'] = this.birthday;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}