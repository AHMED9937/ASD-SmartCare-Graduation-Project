class HistoryAutisumTest {
  String? status;
  List<AutisumTest>? data;

  HistoryAutisumTest({this.status, this.data});

  HistoryAutisumTest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AutisumTest>[];
      json['data'].forEach((v) {
        data!.add(AutisumTest.fromJson(v));
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

class AutisumTest {
  String? sId;
  String? parentId;
  String? type;
  List<int>? inputs;
  Output? output;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AutisumTest({
    this.sId,
    this.parentId,
    this.type,
    this.inputs,
    this.output,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  AutisumTest.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    parentId = json['parentId'];
    type = json['type'];
    inputs = json['inputs'].cast<int>();
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
  int? autismPrediction;

  Output({this.autismPrediction});

  Output.fromJson(Map<String, dynamic> json) {
    autismPrediction = json['autism_prediction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['autism_prediction'] = autismPrediction;
    return data;
  }
}
