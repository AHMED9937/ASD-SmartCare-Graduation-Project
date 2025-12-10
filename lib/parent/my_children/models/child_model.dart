class ParentChildsModel {
  int? results;
  PagenationResult? pagenationResult;
  List<child>? childs;

  ParentChildsModel({this.results, this.pagenationResult, this.childs});

  ParentChildsModel.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    pagenationResult = json['pagenationResult'] != null
        ? PagenationResult.fromJson(json['pagenationResult'])
        : null;
    if (json['data'] != null) {
      childs = <child>[];
      json['data'].forEach((v) {
        childs!.add(child.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (pagenationResult != null) {
      data['pagenationResult'] = pagenationResult!.toJson();
    }
    if (childs != null) {
      data['data'] = childs!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['limit'] = limit;
    data['numOfPage'] = numOfPage;
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

  child({
    this.sId,
    this.parent,
    this.childName,
    this.birthday,
    this.age,
    this.gender,
    this.createdAt,
    this.updatedAt,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['parent'] = parent;
    data['childName'] = childName;
    data['birthday'] = birthday;
    data['age'] = age;
    data['gender'] = gender;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
