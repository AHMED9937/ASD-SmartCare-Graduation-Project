class BookSession {
  String? message;
  Data? data;

  BookSession({this.message, this.data});

  BookSession.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? doctorId;
  String? date;
  String? day;
  String? time;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? parentId;

  Data({
    this.sId,
    this.doctorId,
    this.date,
    this.day,
    this.time,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.parentId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = (json['_id'] ?? json['id']) as String?;

    // Handle doctorId being either a string ID or a populated object
    if (json['doctorId'] is Map) {
      doctorId = (json['doctorId']['_id'] ?? json['doctorId']['id']) as String?;
    } else {
      doctorId = json['doctorId'] as String?;
    }

    // Fallback for different response shapes
    doctorId ??= (json['doctor'] is Map)
        ? (json['doctor']['_id'] ?? json['doctor']['id']) as String?
        : (json['doctor'] as String?);

    date = json['date'] as String?;
    day = json['day'] as String?;
    time = json['time'] as String?;
    status = json['status'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    iV = json['__v'] as int?;

    // Handle parentId similarly
    if (json['parentId'] is Map) {
      parentId = (json['parentId']['_id'] ?? json['parentId']['id']) as String?;
    } else {
      parentId = json['parentId'] as String?;
    }
    parentId ??= json['parent'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['doctorId'] = doctorId;
    data['date'] = date;
    data['day'] = day;
    data['time'] = time;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['parentId'] = parentId;
    return data;
  }
}
