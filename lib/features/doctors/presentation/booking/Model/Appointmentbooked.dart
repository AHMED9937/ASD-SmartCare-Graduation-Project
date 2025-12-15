class BookSession {
  String? message;
  Data? data;

  BookSession({this.message, this.data});

  BookSession.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
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

  Data(
      {this.sId,
      this.doctorId,
      this.date,
      this.day,
      this.time,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.parentId});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    doctorId = json['doctorId'];
    date = json['date'];
    day = json['day'];
    time = json['time'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    parentId = json['parentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['doctorId'] = this.doctorId;
    data['date'] = this.date;
    data['day'] = this.day;
    data['time'] = this.time;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['parentId'] = this.parentId;
    return data;
  }
}