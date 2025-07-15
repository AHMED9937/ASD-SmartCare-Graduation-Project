class HistoryAustisumLevelTest {
  String? status;
  List<AustisumLevelTestData>? data;

  HistoryAustisumLevelTest({this.status, this.data});

  HistoryAustisumLevelTest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AustisumLevelTestData>[];
      json['data'].forEach((v) {
        data!.add(new AustisumLevelTestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AustisumLevelTestData {
  String? sId;
  String? parentId;
  String? type;
  List<String>? inputs;
  Output? output;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AustisumLevelTestData(
      {this.sId,
      this.parentId,
      this.type,
      this.inputs,
      this.output,
      this.createdAt,
      this.updatedAt,
      this.iV});

  AustisumLevelTestData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    parentId = json['parentId'];
    type = json['type'];
    inputs = json['inputs'].cast<String>();
    output =
        json['output'] != null ? new Output.fromJson(json['output']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['parentId'] = this.parentId;
    data['type'] = this.type;
    data['inputs'] = this.inputs;
    if (this.output != null) {
      data['output'] = this.output!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Output {
  int? degreePrediction;

  Output({this.degreePrediction});

  Output.fromJson(Map<String, dynamic> json) {
    degreePrediction = json['degree_prediction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['degree_prediction'] = this.degreePrediction;
    return data;
  }
}