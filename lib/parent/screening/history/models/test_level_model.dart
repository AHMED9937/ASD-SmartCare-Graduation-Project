class HistoryAustisumLevelTest {
  String? status;
  List<AustisumLevelTestData>? data;

  HistoryAustisumLevelTest({this.status, this.data});

  HistoryAustisumLevelTest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AustisumLevelTestData>[];
      json['data'].forEach((v) {
        data!.add(AustisumLevelTestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
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

  AustisumLevelTestData({
    this.sId,
    this.parentId,
    this.type,
    this.inputs,
    this.output,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  AustisumLevelTestData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    parentId = json['parentId'];
    type = json['type'];
    inputs = json['inputs'].cast<String>();
    output = json['output'] != null ? Output.fromJson(json['output']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['parentId'] = parentId;
    data['type'] = type;
    data['inputs'] = inputs;
    if (output != null) {
      data['output'] = output!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['degree_prediction'] = degreePrediction;
    return data;
  }
}
