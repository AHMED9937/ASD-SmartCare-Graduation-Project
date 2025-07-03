class GetAllSessions {
  List<SessionData>? data;

  GetAllSessions({this.data});

  factory GetAllSessions.fromJson(Map<String, dynamic> json) => GetAllSessions(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => SessionData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        if (data != null)
          'data': data!.map((e) => e.toJson()).toList(),
      };
}

class SessionData {
  String? sId;
  Doctor? doctorId;
  ParentId? parentId;
  int? sessionNumber;
  String? sessionDate;
  String? statusOfSession;
  List<String>? comments;
  List<dynamic>? sessionReview;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? id;

  SessionData({
    this.sId,
    this.doctorId,
    this.parentId,
    this.sessionNumber,
    this.sessionDate,
    this.statusOfSession,
    this.comments,
    this.sessionReview,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.id,
  });

  factory SessionData.fromJson(Map<String, dynamic> json) => SessionData(
        sId: json['_id'] as String?,
        doctorId: json['doctorId'] == null
            ? null
            : Doctor.fromJson(json['doctorId'] as Map<String, dynamic>),
        parentId: json['parentId'] == null
            ? null
            : ParentId.fromJson(json['parentId'] as Map<String, dynamic>),
        sessionNumber: json['session_number'] as int?,
        sessionDate: json['session_date'] as String?,
        statusOfSession: json['statusOfSession'] as String?,
        comments: (json['comments'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        sessionReview: json['session_review'] as List<dynamic>?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        iV: json['__v'] as int?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (sId != null) '_id': sId,
        if (doctorId != null) 'doctorId': doctorId!.toJson(),
        if (parentId != null) 'parentId': parentId!.toJson(),
        if (sessionNumber != null) 'session_number': sessionNumber,
        if (sessionDate != null) 'session_date': sessionDate,
        if (statusOfSession != null) 'statusOfSession': statusOfSession,
        if (comments != null) 'comments': comments,
        if (sessionReview != null) 'session_review': sessionReview,
        if (createdAt != null) 'createdAt': createdAt,
        if (updatedAt != null) 'updatedAt': updatedAt,
        if (iV != null) '__v': iV,
        if (id != null) 'id': id,
      };
}

class Doctor {
  String? sId;
  ParentInfo? parent;
  String? image;
  String? id;

  Doctor({this.sId, this.parent, this.image, this.id});

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        sId: json['_id'] as String?,
        parent: json['parent'] == null
            ? null
            : ParentInfo.fromJson(json['parent'] as Map<String, dynamic>),
        image: json['image'] as String?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (sId != null) '_id': sId,
        if (parent != null) 'parent': parent!.toJson(),
        if (image != null) 'image': image,
        if (id != null) 'id': id,
      };
}

class ParentInfo {
  String? sId;
  String? userName;
  String? email;
  List<dynamic>? childs;
  String? id;

  ParentInfo({
    this.sId,
    this.userName,
    this.email,
    this.childs,
    this.id,
  });

  factory ParentInfo.fromJson(Map<String, dynamic> json) => ParentInfo(
        sId: json['_id'] as String?,
        userName: json['userName'] as String?,
        email: json['email'] as String?,
        childs: json['childs'] as List<dynamic>?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (sId != null) '_id': sId,
        if (userName != null) 'userName': userName,
        if (email != null) 'email': email,
        if (childs != null) 'childs': childs,
        if (id != null) 'id': id,
      };
}

class ParentId {
  String? sId;
  String? userName;
  String? email;
  String? role;
  List<Child>? childs;
  String? id;

  ParentId({
    this.sId,
    this.userName,
    this.email,
    this.role,
    this.childs,
    this.id,
  });

  factory ParentId.fromJson(Map<String, dynamic> json) => ParentId(
        sId: json['_id'] as String?,
        userName: json['userName'] as String?,
        email: json['email'] as String?,
        role: json['role'] as String?,
        childs: (json['childs'] as List<dynamic>?)
            ?.map((e) => Child.fromJson(e as Map<String, dynamic>))
            .toList(),
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (sId != null) '_id': sId,
        if (userName != null) 'userName': userName,
        if (email != null) 'email': email,
        if (role != null) 'role': role,
        if (childs != null) 'childs': childs!.map((e) => e.toJson()).toList(),
        if (id != null) 'id': id,
      };
}

class Child {
  String? sId;
  String? childName;
  String? age;
  String? gender;

  Child({this.sId, this.childName, this.age, this.gender});

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        sId: json['_id'] as String?,
        childName: json['childName'] as String?,
        age: json['age'] as String?,
        gender: json['gender'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (sId != null) '_id': sId,
        if (childName != null) 'childName': childName,
        if (age != null) 'age': age,
        if (gender != null) 'gender': gender,
      };
}
