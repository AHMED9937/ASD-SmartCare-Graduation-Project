class AppointmentsResponse {
  String? message;
  List<Appointment>? appointment;

  AppointmentsResponse({this.message, this.appointment});

  AppointmentsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['appointment'] != null) {
      appointment = <Appointment>[];
      json['appointment'].forEach((v) {
        appointment!.add(new Appointment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.appointment != null) {
      data['appointment'] = this.appointment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Appointment {
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

  Appointment(
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

  Appointment.fromJson(Map<String, dynamic> json) {
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