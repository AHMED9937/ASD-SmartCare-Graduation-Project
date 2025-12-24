class GetDoctorAvailability {
  String? message;
  List<Availability>? data;

  GetDoctorAvailability({this.message, this.data});

  GetDoctorAvailability.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Availability>[];
      json['data'].forEach((v) {
        data!.add(Availability.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Availability {
  String? sId;
  String? date;
  String? day;
  String? time;

  Availability({this.sId, this.date, this.day, this.time});

  Availability.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    day = json['day'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['date'] = date;
    data['day'] = day;
    data['time'] = time;
    return data;
  }
}
