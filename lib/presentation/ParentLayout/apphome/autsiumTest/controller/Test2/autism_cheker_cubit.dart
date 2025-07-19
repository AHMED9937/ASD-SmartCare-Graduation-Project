import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/autsiumTest/controller/Test2/autism_cheker_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/autsiumTest/model/PredictionMessage.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/StlsAppTextFormField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Test2AutsiumCubit extends Cubit<Test2AutsiumStates> {
  Test2AutsiumCubit() : super(Test2AutsiuminitialState()) {
    // initialize one controller per question
    ansControllers = List.generate(degree_questions.length,
        (index) => TextEditingController());
    _pages = buildQuestionWidgets();
  }
  static Test2AutsiumCubit get(context) => BlocProvider.of(context);

  /// One text controller per question
  late final List<TextEditingController> ansControllers;
  int _currentAge = 0;
  int _currentIndex = 0;
  late final List<Widget> _pages;
  

  /// Public getters
  List<Widget> get pages => _pages;
  int get currentIndex => _currentIndex;
  PredictionMessage? msg;

  final List<String>degree_questions = [
    "What is your child’s age in years?",
    "What is the sex of your child (Male/Female)?",
    "Please describe your child's communication abilities in your own words.",
    "Please describe your child's social communication and interaction skills.",
    "Please describe your child's non-verbal communication abilities.",
    "How does your child handle developing, maintaining, and understanding relationships?",
    "Can you describe any repetitive behaviors or patterns you have noticed in your child?",
    "How does your child react to various sensory stimuli? Please elaborate.",
    "Apart from Autism, are there any other challenges your child faces? (For example, ADHD, Epilepsy, Specific Learning Difficulties, Speech Delay, or none.)"
];
Widget QSType1(int index, String Qs) => Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Center(
      child: Text(
        Qs,
        style: TextStyle(color: Colors.black, fontSize: 15),
        overflow: TextOverflow.clip,
      ),
    ),
    const SizedBox(height: 16),

    // <-- built‑in TextFormField instead of StlsAppTextFormField
    Expanded(
      child: TextFormField(
        controller: ansControllers[index],
        decoration: InputDecoration(
          hintText: 'Answer here',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(33)),
        ),
        maxLines:7, // allows the field to grow up to 3 lines
      ),
    ),
  ],
);
  Widget QSType2(String Qs,int QSIndex) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextUtils.textHeader(Qs, headerTextColor: Colors.black, fontSize: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (_currentAge > 0)
                   {
                    _currentAge--;
                    ansControllers[QSIndex].text="${_currentAge}";
                  emit(Test2AutsiumIDXChangeState());
                  }
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
              TextUtils.textHeader('${_currentAge}y', fontSize: 20),
              IconButton(
                onPressed: () {
                  if (_currentAge < 100) 
                { 
                   _currentAge++;
                    ansControllers[QSIndex].text="${_currentAge}";

                  emit(Test2AutsiumIDXChangeState());
                }
                },
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              ),
            ],
          ),
        ],
      );

  Widget QSType3(String Qs,int QSIndex) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextUtils.textHeader(Qs, headerTextColor: Colors.black),
          AppButtons.containerTextButton(
            TextUtils.textHeader('male', headerTextColor: Colors.white),
            () { 
                    ansControllers[QSIndex].text="male";
              
              emit(Test2AutsiumIDXChangeState());},
          ),
          const SizedBox(height: 8),
          AppButtons.containerTextButton(
            TextUtils.textHeader('female', headerTextColor: Colors.white),
            () { 
                    ansControllers[QSIndex].text="female";
              
              emit(Test2AutsiumIDXChangeState());},
            containerColor: const Color(0xFF8FADE1),
          ),
        ],
      );

  List<Widget> buildQuestionWidgets() {
    return List.generate(degree_questions.length, (i) {
      switch (i) {
        case 0:
          return QSType2(degree_questions[i],i);
        case 1:
          return QSType3(degree_questions[i],i);
        default:
          return QSType1(i, degree_questions[i]);
      }
    });
  }

  /// Navigate to next question, saving the text answer
  void next() {
    // read answer for text questions
    final answer = ansControllers[_currentIndex].text;
    print('Answer Q${_currentIndex + 1}: $answer');

    if (_currentIndex < pages.length - 1) {
      _currentIndex++;
      emit(Test2AutsiumIDXChangeState());
    }
  }

  /// Navigate back
  void prev() {
    if (_currentIndex > 0) {
      _currentIndex--;
      emit(Test2AutsiumIDXChangeState());
    }
  }
Future<void> reasonFinalPredictionForQs() async {
  emit(Test2GetQsfinalPredicationLoadingState());

  final token = CacheHelper.getData(key: "token") as String?;
  final answer = ansControllers[_currentIndex].text;

  if (token == null || token.isEmpty) {
    emit(Test2GetQsfinalPredicationErrorState(
      message: 'Missing authentication token',
    ));
    return;
  }

  try {
    final response = await Diohelper.PostData(
      url: ApiConstants.QSfinalPredicationDgree,
      token: token,
      data: {
        "index": _currentIndex,
        "answer": answer,
      },
    );

    // 1) Check server status
    if (response.statusCode != 200) {
      emit(Test2GetQsfinalPredicationErrorState(
        message: 'Server returned ${response.statusCode}',
      ));
      return;
    }

    // 2) Parse into your flat model
    final prediction = PredictionMessage.fromJson(
      response.data as Map<String, dynamic>,
    );

    // 3) Make sure we got a degreePrediction
    final degree = prediction.degreePrediction;
    if (degree == null && _currentIndex == 8) {
      emit(Test2GetQsfinalPredicationErrorState(
        message: 'No degree_prediction in response',
      ));
      return;
    }

    // 4) Only emit success when you're at the final question (index 8)
    if (_currentIndex == 8) {
      emit(Test2GetQsfinalPredicationSuccessState(degree));
    } else {
      // maybe you want a different state for intermediate steps?
      emit(Test2GetOneQsPredicationSuccessState());
    }
  } catch (e, st) {
    print('Error in reasonFinalPredictionForQs:\n$e\n$st');
    emit(Test2GetQsfinalPredicationErrorState(
      message: e.toString(),
    ));
  }
}

}