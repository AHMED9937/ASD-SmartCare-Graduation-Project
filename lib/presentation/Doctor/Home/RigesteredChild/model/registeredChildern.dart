class RegisteredChildren {
  String? message;
  List<Parents>? parents;

  RegisteredChildren({this.message, this.parents});

  RegisteredChildren.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['parents'] != null) {
      parents = <Parents>[];
      json['parents'].forEach((v) {
        parents!.add(new Parents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.parents != null) {
      data['parents'] = this.parents!.map((v) => v.toJson()).toList();
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
        childs!.add(new Childs.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    if (this.childs != null) {
      data['childs'] = this.childs!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['childName'] = this.childName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    return data;
  }
}