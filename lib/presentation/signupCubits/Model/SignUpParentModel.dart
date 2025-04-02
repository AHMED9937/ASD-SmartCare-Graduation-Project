class SignupParentModel {
  final String status;
  final UserData data;
  final String token;

  SignupParentModel({
    required this.status,
    required this.data,
    required this.token,
  });

  // Factory method to create a SignupParentModel object from JSON
  factory SignupParentModel.fromJson(Map<String, dynamic> json) {
    return SignupParentModel(
      status: json['status'],
      data: UserData.fromJson(json['data']),
      token: json['token'],
    );
  }

  // Convert SignupParentModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
      'token': token,
    };
  }
}

class UserData {
  final String user;
  final String childName;
  final String birthday;
  final String gender;
  final String address;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  UserData({
    required this.user,
    required this.childName,
    required this.birthday,
    required this.gender,
    required this.address,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  // Factory method to create a UserData object from JSON
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: json['user'],
      childName: json['childName'],
      birthday: json['birthday'],
      gender: json['gender'],
      address: json['address'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  // Convert UserData object to JSON
  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'childName': childName,
      'birthday': birthday,
      'gender': gender,
      'address': address,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
