// autism_test_cubit.dart
import 'dart:io';

import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/parent/screening/test/views/audio_recorder_screen.dart';
import 'package:asdsmartcare/parent/screening/test/controllers/autism_test_state.dart';
import 'package:asdsmartcare/parent/screening/results/models/prediction_model.dart';
import 'package:asdsmartcare/core/utils/text_utils.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AutismTestCubit extends Cubit<AutismTestStates> {
  AutismTestCubit() : super(AutismTestInitialState()) {
    // initialize one controller per question
    ansControllers = List.generate(
      questionsCheckAutism.length,
      (index) => TextEditingController(),
    );
    _pages = buildQuestionWidgets();
  }

  static AutismTestCubit get(context) => BlocProvider.of(context);

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
  String fileP = '';
  String fileN = '';
  FilePickerResult? myfile;

  String RecordedFileP = '';

  final List<String> questionsCheckAutism = [
    'Does your child look at you when you call his/her name?',
    'Is eye contact easy between you and your child?',
    'Does your child point to indicate that s/he wants something?',
    'Does your child point to share interest with you?',
    'Does your child pretend?',
    "Does your child follow where you're looking?",
    "Does your child show signs of wanting to comfort someone who's upset?",
    'Has your child started speaking early?',
    'Does your child use simple gestures? (e.g. wave goodbye)',
    'Does your child stare at nothing with no apparent purpose?',
    "What is your child's age in months?",
    'What is the sex of your child (Male/Female)?',
    'Has your child ever had jaundice?',
    'Is there a family member with ASD (Autism Spectrum Disorder)?',
  ];

  /// Free-text question widget, now tied to its own controller
  Widget QSType1(int index, String Qs) =>
      MyAudioRecorder(question: Qs, controller: ansControllers[index]);

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
                ansControllers[QSIndex].text = '$_currentAge';
                emit(AutismTestChangeState());
              }
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          TextUtils.textHeader('$_currentAge m', fontSize: 20),
          IconButton(
            onPressed: () {
              if (_currentAge < 100) {
                _currentAge++;
                ansControllers[QSIndex].text = '$_currentAge';
                emit(AutismTestChangeState());
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
      AppButton(
        label: 'male',
        onPressed: () {
          ansControllers[QSIndex].text = 'male';
          emit(AutismTestChangeState());
        },
      ),
      const SizedBox(height: 8),
      AppButton.secondary(
        label: 'female',
        onPressed: () {
          ansControllers[QSIndex].text = 'female';
          emit(AutismTestChangeState());
        },
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
    debugPrint('Answer Q${_currentIndex + 1}: $answer');

    if (_currentIndex < questionsCheckAutism.length - 1) {
      _currentIndex++;
      // Clear audio state for the next question
      fileP = '';
      fileN = '';
      emit(AutismTestChangeState());
    }
  }

  /// Navigate back
  void prev() {
    if (_currentIndex > 0) {
      _currentIndex--;
      // Clear audio state when navigating back to ensure fresh state
      fileP = '';
      fileN = '';
      emit(AutismTestChangeState());
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
      final Directory? dir = await getExternalStorageDirectory();
      RecordedFileP = '${dir!.path}/ASD.mp3';
      await recorder.startRecorder(toFile: RecordedFileP);
    } catch (err) {
      debugPrint('Recording error: $err');
    }
  }

  Future<void> StopRecord() async {
    try {
      await recorder.stopRecorder();
      await recorder.closeRecorder();
      RecordedFileP = RecordedFileP;
    } catch (err) {
      debugPrint('Stop recording error: $err');
    }
  }

  Future<void> reasonFinalPredictionForQs() async {
    emit(GetQsFinalPredictionLoadingState());
    final token = CacheHelper.getData(key: 'token');
    debugPrint('Token retrieved for prediction');
    if (token == null) {
      emit(GetQsFinalPredictionErrorState(err: 'No token found'));
      return;
    }

    // trim the text field
    final rawAnswer = ansControllers[_currentIndex].text.trim();
    final hasText = rawAnswer.isNotEmpty;
    final hasAudio = fileP.isNotEmpty;

    if (!hasText && !hasAudio) {
      emit(
        GetQsFinalPredictionErrorState(
          err: 'Please enter text or pick an audio file',
        ),
      );
      return;
    }

    // build the multipart body with mutual exclusion
    final map = <String, dynamic>{
      'index': currentIndex,
      if (hasText)
        'answer': rawAnswer
      else
        'audio': await MultipartFile.fromFile(
          fileP,
          filename: fileN,
          contentType: DioMediaType('audio', 'mpeg'),
        ),
    };
    final formData = FormData.fromMap(map);
    debugPrint(
      'Sending prediction request with ${formData.files.length} files',
    );
    try {
      final response = await Diohelper.postData(
        url: ApiConstants.QSfinalPredication,
        token: token,
        data: formData,
      );
      final prediction = PredictionMessage.fromJson(response.data);
      if (_currentIndex == 13) {
        final result =
            prediction.autismPrediction ??
            CacheHelper.getData(key: 'autism_prediction') ??
            0;
        emit(
          GetQsFinalPredictionSuccessState(
            result is int ? result : int.tryParse(result.toString()) ?? 0,
          ),
        );
      } else {
        emit(GetOneQsPredictionSuccessState());
      }
    } catch (e) {
      emit(GetQsFinalPredictionErrorState());
    }
  }

  /// Fetches autism screening history for the current child.
  ///
  /// This will be integrated with the backend API in a future release
  /// to display historical test results on the progress dashboard.
  void getChildAutismHistory() {
    debugPrint('getChildAutismHistory: Feature pending backend integration');
  }
}
