class PredictionMessage {
  final String? message;
  final int? autismPrediction;
  final int? degreePrediction;

  PredictionMessage({
    this.message,
    this.autismPrediction,
    this.degreePrediction,
  });

  factory PredictionMessage.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    int? parsePrediction(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    return PredictionMessage(
      message: json['message'] as String?,
      autismPrediction: parsePrediction(data?['autism_prediction']),
      degreePrediction: parsePrediction(data?['degree_prediction']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (message != null) {
      result['message'] = message;
    }
    result['data'] = {
      if (autismPrediction != null) 'autism_prediction': autismPrediction,
      if (degreePrediction != null) 'degree_prediction': degreePrediction,
    };
    return result;
  }
}
