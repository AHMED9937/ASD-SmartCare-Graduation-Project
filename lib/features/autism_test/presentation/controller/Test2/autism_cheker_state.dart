
abstract class Test2AutsiumStates{}
class Test2AutsiuminitialState extends Test2AutsiumStates{}

class Test2AutsiumIDXChangeState extends Test2AutsiumStates{}

class Test2GetQsfinalPredicationLoadingState extends Test2AutsiumStates{}
class Test2GetQsfinalPredicationSuccessState extends Test2AutsiumStates{
   int ?degree_prediction;
   Test2GetQsfinalPredicationSuccessState(this.degree_prediction);
}
class Test2GetOneQsPredicationSuccessState extends Test2AutsiumStates{
  
}
class Test2GetQsfinalPredicationErrorState extends Test2AutsiumStates{
 String message;
 Test2GetQsfinalPredicationErrorState({required this.message});
}