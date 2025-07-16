class ParentBookedDoctors {
  String? message;
  List<Doctors>? doctors;

  ParentBookedDoctors({this.message, this.doctors});

  ParentBookedDoctors.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(new Doctors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.doctors != null) {
      data['doctors'] = this.doctors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctors {
  String? sId;
  Parent? parent;
  String? id;

  Doctors({this.sId, this.parent, this.id});

  Doctors.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Parent {
  String? sId;
  String? userName;
  String? email;
  String? id;

  Parent({this.sId, this.userName, this.email, this.id});

  Parent.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['id'] = this.id;
    return data;
  }
}