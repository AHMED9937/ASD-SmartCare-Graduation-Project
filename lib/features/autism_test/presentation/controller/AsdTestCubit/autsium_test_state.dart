
abstract class AutsiumTestStates{}

class AutsiumTestinitialState extends AutsiumTestStates{}

class AutsiumTestChangeState extends AutsiumTestStates{}

class GetQsfinalPredicationLoadingState extends AutsiumTestStates{}
class GetQsfinalPredicationSuccessState extends AutsiumTestStates{
  final int prediction;
   GetQsfinalPredicationSuccessState(this.prediction);
}
class GetOneQsPredicationSuccessState extends AutsiumTestStates{
  
}
class RecordingChangeState extends AutsiumTestStates{}
class GetQsfinalPredicationErrorState extends AutsiumTestStates{
  String ?err;
  GetQsfinalPredicationErrorState({this.err});
}