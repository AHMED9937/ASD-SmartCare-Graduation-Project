abstract class AutismTestStates {}

class AutismTestInitialState extends AutismTestStates {}

class AutismTestChangeState extends AutismTestStates {}

class GetQsFinalPredictionLoadingState extends AutismTestStates {}

class GetQsFinalPredictionSuccessState extends AutismTestStates {
  final int prediction;
  GetQsFinalPredictionSuccessState(this.prediction);
}

class GetOneQsPredictionSuccessState extends AutismTestStates {}

class RecordingChangeState extends AutismTestStates {}

class GetQsFinalPredictionErrorState extends AutismTestStates {
  String? err;
  GetQsFinalPredictionErrorState({this.err});
}
