// child_model.dart

/// Represents a server response wrapping a [ChildData] object.
class ChildResponse {
  final ChildData data;

  ChildResponse({
    required this.data,
  });

  /// Creates a new [ChildResponse] from a JSON map.
  factory ChildResponse.fromJson(Map<String, dynamic> json) {
    return ChildResponse(
      data: ChildData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  /// Converts this [ChildResponse] into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}

/// Represents the detailed child data returned by the server.
class ChildData {
  final String parent;
  final String childName;
  final String birthday;
  final int age;
  final String gender;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ChildData({
    required this.parent,
    required this.childName,
    required this.birthday,
    required this.age,
    required this.gender,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  /// Creates a new [ChildData] from a JSON map.
  factory ChildData.fromJson(Map<String, dynamic> json) {
    return ChildData(
      parent: json['parent'] as String,
      childName: json['childName'] as String,
      birthday: json['birthday'] as String,
      age: int.tryParse(json['age'] as String) ?? 0,
      gender: json['gender'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }

  /// Converts this [ChildData] into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'parent': parent,
      'childName': childName,
      'birthday': birthday,
      'age': age.toString(),
      'gender': gender,
      '_id': id,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
      '__v': v,
    };
  }
}
