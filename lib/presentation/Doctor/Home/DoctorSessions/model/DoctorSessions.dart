import 'package:intl/intl.dart';

/// Represents a list of sessions received from the API.
class SessionsResponse {
  final List<Session>? data;

  SessionsResponse({this.data});

  factory SessionsResponse.fromJson(Map<String, dynamic> json) {
    return SessionsResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Session.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (data != null)
          'data': data!.map((session) => session.toJson()).toList(),
      };
}

/// Represents a single session between a doctor and a parent.
class Session {
  final String? id;
  final DoctorData? doctor;
  final ParentData? parent;
  final int? sessionNumber;
  final DateTime? sessionDate;
  final String? statusOfSession;
  final List<String>? comments;
  final List<dynamic>? sessionReview;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Session({
    this.id,
    this.doctor,
    this.parent,
    this.sessionNumber,
    this.sessionDate,
    this.statusOfSession,
    this.comments,
    this.sessionReview,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    // Parse session_date which comes in M/d/yyyy format
    DateTime? parsedSessionDate;
    final dateString = json['session_date'] as String?;
    if (dateString != null && dateString.isNotEmpty) {
      try {
        parsedSessionDate = DateFormat('M/d/yyyy').parse(dateString);
      } catch (_) {
        parsedSessionDate = null;
      }
    }

    return Session(
      id: (json['id'] as String?) ?? (json['_id'] as String?),
      doctor: json['doctorId'] != null
          ? DoctorData.fromJson(json['doctorId'] as Map<String, dynamic>)
          : null,
      parent: json['parentId'] != null
          ? ParentData.fromJson(json['parentId'] as Map<String, dynamic>)
          : null,
      sessionNumber: json['session_number'] as int?,
      sessionDate: parsedSessionDate,
      statusOfSession: json['statusOfSession'] as String?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sessionReview: json['session_review'] != null
          ? List<dynamic>.from(json['session_review'] as List)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      '_id': id,
      'id': id,
      'session_number': sessionNumber,
      'statusOfSession': statusOfSession,
      '__v': v,
    };

    if (doctor != null) map['doctorId'] = doctor!.toJson();
    if (parent != null) map['parentId'] = parent!.toJson();
    if (sessionDate != null) {
      map['session_date'] = DateFormat('M/d/yyyy').format(sessionDate!);
    }
    if (comments != null) map['comments'] = comments;
    if (sessionReview != null) map['session_review'] = sessionReview;
    if (createdAt != null) map['createdAt'] = createdAt!.toIso8601String();
    if (updatedAt != null) map['updatedAt'] = updatedAt!.toIso8601String();

    return map;
  }
}

/// Minimal doctor info nested inside a session.
class DoctorData {
  final String? id;
  final DoctorParent? parent;
  final String? image;

  DoctorData({this.id, this.parent, this.image});

  factory DoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorData(
      id: (json['id'] as String?) ?? (json['_id'] as String?),
      parent: json['parent'] != null
          ? DoctorParent.fromJson(json['parent'] as Map<String, dynamic>)
          : null,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'id': id,
        if (parent != null) 'parent': parent!.toJson(),
        'image': image,
      };
}

/// Parent info for a doctor inside a session.
class DoctorParent {
  final String? id;
  final String? userName;
  final String? email;
  final List<dynamic>? childs;

  DoctorParent({this.id, this.userName, this.email, this.childs});

  factory DoctorParent.fromJson(Map<String, dynamic> json) {
    return DoctorParent(
      id: (json['id'] as String?) ?? (json['_id'] as String?),
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      childs: json['childs'] != null
          ? List<dynamic>.from(json['childs'] as List)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'id': id,
        'userName': userName,
        'email': email,
        if (childs != null) 'childs': childs,
      };
}

/// Parent who booked the session.
class ParentData {
  final String? id;
  final String? userName;
  final String? email;
  final String? role;
  final List<Child>? childs;

  ParentData({this.id, this.userName, this.email, this.role, this.childs});

  factory ParentData.fromJson(Map<String, dynamic> json) {
    return ParentData(
      id: (json['id'] as String?) ?? (json['_id'] as String?),
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      childs: (json['childs'] as List<dynamic>?)
          ?.map((e) => Child.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'id': id,
        'userName': userName,
        'email': email,
        'role': role,
        if (childs != null) 'childs': childs!.map((c) => c.toJson()).toList(),
      };
}

/// A child record under a parent.
class Child {
  final String? id;
  final String? childName;
  final String? age;
  final String? gender;

  Child({this.id, this.childName, this.age, this.gender});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: (json['id'] as String?) ?? (json['_id'] as String?),
      childName: json['childName'] as String?,
      age: json['age'] as String?,
      gender: json['gender'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'id': id,
        'childName': childName,
        'age': age,
        'gender': gender,
      };
}
