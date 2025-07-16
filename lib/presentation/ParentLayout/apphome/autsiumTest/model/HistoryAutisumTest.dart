class HistoryAutisumTest {
  String? status;
  List<AutisumTest>? data;

  HistoryAutisumTest({this.status, this.data});

  HistoryAutisumTest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AutisumTest>[];
      json['data'].forEach((v) {
        data!.add(new AutisumTest.fromJson(v));
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

class AutisumTest {
  String? sId;
  String? parentId;
  String? type;
  List<int>? inputs;
  Output? output;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AutisumTest(
      {this.sId,
      this.parentId,
      this.type,
      this.inputs,
      this.output,
      this.createdAt,
      this.updatedAt,
      this.iV});

  AutisumTest.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    parentId = json['parentId'];
    type = json['type'];
    inputs = json['inputs'].cast<int>();
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
  int? autismPrediction;

  Output({this.autismPrediction});

  Output.fromJson(Map<String, dynamic> json) {
    autismPrediction = json['autism_prediction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['autism_prediction'] = this.autismPrediction;
    return data;
  }
}