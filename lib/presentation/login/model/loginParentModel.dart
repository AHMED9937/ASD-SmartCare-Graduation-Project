class LoginParentModel {
  final ParentData data;
  final String token;

  LoginParentModel({
    required this.data,
    required this.token,
  });

  factory LoginParentModel.fromJson(Map<String, dynamic> json) {
    return LoginParentModel(
      data: ParentData.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
        'token': token,
      };
}

class ParentData {
  final String id;
  final String userName;
  final String email;
  final String password;
  final int age;
  final String phone;
  final String address;
  final bool active;
  final String role;
  final int numOfChild;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String? emailResetCode;
  final DateTime? emailResetExpire;
  final bool? emailResetVerified;

  ParentData({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.age,
    required this.phone,
    required this.address,
    required this.active,
    required this.role,
    required this.numOfChild,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.emailResetCode,
    this.emailResetExpire,
    this.emailResetVerified,
  });

  factory ParentData.fromJson(Map<String, dynamic> json) {
    return ParentData(
      id: json['_id'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      age: json['age'] as int,
      phone: json['phone'] as String,
      address: json['address'] as String,
      active: json['active'] as bool,
      role: json['role'] as String,
      numOfChild: json['numOfChild'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
      emailResetCode: json['emailResetCode'] as String?,
      emailResetExpire: json['emailResetExpire'] != null
          ? DateTime.parse(json['emailResetExpire'] as String)
          : null,
      emailResetVerified: json['emailResetVerfied'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userName': userName,
        'email': email,
        'password': password,
        'age': age,
        'phone': phone,
        'address': address,
        'active': active,
        'role': role,
        'numOfChild': numOfChild,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        '__v': v,
        if (emailResetCode != null) 'emailResetCode': emailResetCode,
        if (emailResetExpire != null)
          'emailResetExpire': emailResetExpire!.toIso8601String(),
        if (emailResetVerified != null)
          'emailResetVerfied': emailResetVerified,
      };
}
