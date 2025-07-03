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
    return PredictionMessage(
      message: json['message'] as String?,
      autismPrediction: data?['autism_prediction'] as int?,
      degreePrediction: data?['degree_prediction'] as int?,
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
