// autsium_test_cubit.dart
import 'dart:io';

import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/autsiumTest/Widgets/MyAudioRecorder.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/autsiumTest/controller/AsdTestCubit/autsium_test_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/autsiumTest/model/PredictionMessage.dart';
import 'package:asdsmartcare/presentation/ParentLayout/apphome/autsiumTest/model/asdREQmodel.dart';
import 'package:asdsmartcare/presentation/ParentLayout/chatBotLayout/Controller/ChatBotcubit/chat_bot_state.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class AutsiumTestCubit extends Cubit<AutsiumTestStates> {
  AutsiumTestCubit() : super(AutsiumTestinitialState()) {
    // initialize one controller per question
    ansControllers = List.generate(
        questionsCheckAutism.length, (index) => TextEditingController());
    _pages = buildQuestionWidgets();
  }
  static AutsiumTestCubit get(context) => BlocProvider.of(context);

  /// One text controller per question
  late final List<TextEditingController> ansControllers;
  int _currentAge = 0;
  int _currentIndex = 0;
  late final List<Widget> _pages;
  FlutterSoundRecorder recorder = FlutterSoundRecorder();

  /// Public getters
  List<Widget> get pages => _pages;
  int get currentIndex => _currentIndex;
  PredictionMessage? msg;
  bool isRecording = false;
  final AudioRecorder audioRecorder = AudioRecorder();
  String? RecordingPath;
  String fileP = "";
  String fileN = "";
  FilePickerResult? myfile;

  String RecordedFileP = "";

  final List<String> questionsCheckAutism = [
    "Does your child look at you when you call his/her name?",
    "Is eye contact easy between you and your child?",
    "Does your child point to indicate that s/he wants something?",
    "Does your child point to share interest with you?",
    "Does your child pretend?",
    "Does your child follow where you’re looking?",
    "Does your child show signs of wanting to comfort someone who’s upset?",
    "Has your child started speaking early?",
    "Does your child use simple gestures? (e.g. wave goodbye)",
    "Does your child stare at nothing with no apparent purpose?",
    "What is your child’s age in months?",
    "What is the sex of your child (Male/Female)?",
    "Has your child ever had jaundice?",
    "Is there a family member with ASD (Autism Spectrum Disorder)?"
  ];

  // Future<void> pickAudioFile(int index) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['mp3'],
  //   );
  //   if (result != null && result.files.single.path != null) {
  //     fileP = result.files.single.path!;
  //     fileN = result.files.single.name;
  //     myfile = result;

  //   }
  // }

  /// Free-text question widget, now tied to its own controller
  Widget QSType1(int index, String Qs) => MyAudioRecorder(question: Qs,controller:  ansControllers[index],);
  Widget QSType2(String Qs, int QSIndex) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextUtils.textHeader(Qs, headerTextColor: Colors.black, fontSize: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (_currentAge > 0) {
                    _currentAge--;
                    ansControllers[QSIndex].text = "${_currentAge}";
                    emit(AutsiumTestChangeState());
                  }
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
              TextUtils.textHeader('${_currentAge} m', fontSize: 20),
              IconButton(
                onPressed: () {
                  if (_currentAge < 100) {
                    _currentAge++;
                    ansControllers[QSIndex].text = "${_currentAge}";

                    emit(AutsiumTestChangeState());
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              ),
            ],
          ),
        ],
      );

  Widget QSType3(String Qs, int QSIndex) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextUtils.textHeader(Qs, headerTextColor: Colors.black),
          AppButtons.containerTextButton(
            TextUtils.textHeader('male', headerTextColor: Colors.white),
            () {
              ansControllers[QSIndex].text = "male";

              emit(AutsiumTestChangeState());
            },
          ),
          const SizedBox(height: 8),
          AppButtons.containerTextButton(
            TextUtils.textHeader('female', headerTextColor: Colors.white),
            () {
              ansControllers[QSIndex].text = "female";

              emit(AutsiumTestChangeState());
            },
            containerColor: const Color(0xFF8FADE1),
          ),
        ],
      );

  List<Widget> buildQuestionWidgets() {
    return List.generate(questionsCheckAutism.length, (i) {
      switch (i) {
        case 10:
          return QSType2(questionsCheckAutism[i], i);
        case 11:
          return QSType3(questionsCheckAutism[i], i);
        default:
          return QSType1(i, questionsCheckAutism[i]);
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
      emit(AutsiumTestChangeState());
    }
  }

  /// Navigate back
  void prev() {
    if (_currentIndex > 0) {
      _currentIndex--;
      emit(AutsiumTestChangeState());
    }
  }

  /// Call this from your UI when the user picks an MP3
  Future<void> pickAudioFile(int index) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    if (result != null && result.files.single.path != null) {
      fileP = result.files.single.path!;
      fileN = result.files.single.name;
      // clear any text answer
      ansControllers[index].clear();
      emit(RecordingChangeState());
    }
  }

  Future<void> startRecord() async {
    try {
      await recorder.openRecorder();
      Directory? dir = await getExternalStorageDirectory();
      RecordedFileP = "${dir!.path}/ASD.mp3";

      await recorder.startRecorder(
        toFile: RecordedFileP
      );
    } catch (err) {
      print(err);
    }
  }
   Future<void> StopRecord() async {
    try {
      await recorder.stopRecorder();
      await recorder.closeRecorder();
      RecordedFileP=RecordedFileP;
    } catch (err) {
      print(err);
    }
  }

  Future<void> reasonFinalPredictionForQs() async {
    emit(GetQsfinalPredicationLoadingState());
    final token = CacheHelper.getData(key: "token");
    print(token);
    if (token == null) {
      emit(GetQsfinalPredicationErrorState(err: "No token found"));
      return;
    }

    // trim the text field
    final rawAnswer = ansControllers[_currentIndex].text.trim();
    final hasText = rawAnswer.isNotEmpty;
    final hasAudio = fileP != null;

    if (!hasText && !hasAudio) {
      emit(GetQsfinalPredicationErrorState(
          err: "Please enter text or pick an audio file"));
      return;
    }

    // build the multipart body with mutual exclusion
    final map = <String, dynamic>{
      'index': currentIndex,
      if (hasText)
        'answer': rawAnswer
      else
        'audio': await MultipartFile.fromFile(
          fileP!,
          filename: fileN,
          contentType: DioMediaType('audio', 'mpeg'),
        ),
    };
    final formData = FormData.fromMap(map);
    print("=========================");
    print(formData.files);
    try {
      final response = await Diohelper.PostData(
        url: ApiConstants.QSfinalPredication,
        token: token,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      final prediction = PredictionMessage.fromJson(response.data);
      if (_currentIndex == 13) {
        emit(GetQsfinalPredicationSuccessState(prediction.autismPrediction??CacheHelper.getData(key: "autism_prediction")));
      } else {
        emit(GetOneQsPredicationSuccessState());
      }
    } catch (e) {
      emit(GetQsfinalPredicationErrorState());
    }
  }


void GetChildAutsiumHistory(){


  }

}
