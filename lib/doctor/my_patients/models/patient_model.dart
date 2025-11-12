class RegisteredChildren {
  String? message;
  List<Parents>? parents;

  RegisteredChildren({this.message, this.parents});

  RegisteredChildren.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['parents'] != null) {
      parents = <Parents>[];
      json['parents'].forEach((v) {
        parents!.add(Parents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (parents != null) {
      data['parents'] = parents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parents {
  String? sId;
  String? userName;
  String? email;
  List<Childs>? childs;
  String? id;

  Parents({this.sId, this.userName, this.email, this.childs, this.id});

  Parents.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    if (json['childs'] != null) {
      childs = <Childs>[];
      json['childs'].forEach((v) {
        childs!.add(Childs.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['email'] = email;
    if (childs != null) {
      data['childs'] = childs!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class Childs {
  String? sId;
  String? childName;
  String? age;
  String? gender;

  Childs({this.sId, this.childName, this.age, this.gender});

  Childs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    childName = json['childName'];
    age = json['age'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['childName'] = childName;
    data['age'] = age;
    data['gender'] = gender;
    return data;
  }
}
