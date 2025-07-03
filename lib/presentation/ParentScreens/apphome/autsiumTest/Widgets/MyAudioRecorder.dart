import 'dart:io';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/controller/AsdTestCubit/autsium_test_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:record/record.dart';

class MyAudioRecorder extends StatefulWidget {
  final String question;
  final TextEditingController controller;
  
  const MyAudioRecorder({
    Key? key,
    required this.question,
    required this.controller,
  }) : super(key: key);

  @override
  _MyAudioRecorderState createState() => _MyAudioRecorderState();
}

class _MyAudioRecorderState extends State<MyAudioRecorder> {

  late final FlutterSoundRecorder _recorder;
  bool isPlaying = false;
  bool isRecording = false;
  String? recordedFilePath;
  final AudioPlayer audioPlayer = AudioPlayer();

  final AudioRecorder audioRecorder = AudioRecorder();
  void initState() {
    super.initState();
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() => isPlaying = false);
      }
    });
  }
  
  @override
  void didUpdateWidget(covariant MyAudioRecorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the question text changed, clear all recording/playback state:
    if (oldWidget.question != widget.question) {
      setState(() {
        isRecording = false;
        isPlaying   = false;
        recordedFilePath = null;
        widget.controller.clear();
      });
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
                
                final cubit = context.read<AutsiumTestCubit>();

    return Column(
      children: [
        Text( widget.question,style:TextStyle( color: Colors.black,  fontSize: 15,) ,overflow: TextOverflow.clip),
        const SizedBox(height: 16),
        Appformtextfield(
          hintText: recordedFilePath!=null?'audio Uploded':"",
          TextController: widget.controller,
          prefixIcon: IconButton(
            icon: Icon(isRecording ? Icons.stop : Icons.mic),
            onPressed: () async {
              if (isRecording) {
                final String? filePath = await audioRecorder.stop();
                if (filePath != null) {
                  setState(() {
                    isRecording = false;
                    recordedFilePath = filePath;
                    cubit.fileP=filePath;
                    cubit.fileN=filePath;
                    cubit.reasonFinalPredictionForQs();
                  });
                }
              } else {
                if (await audioRecorder.hasPermission()) {
                  final Directory dir =
                      await getApplicationDocumentsDirectory();
                  final String filePath = p.join(dir.path, "ASD.mp3");
                  setState(() {
                    isRecording = true;
                    recordedFilePath = null;
                  });
                  await audioRecorder.start(RecordConfig(), path: filePath);
                }
              }
            },
          ),
        ),
        PlayUi(),
      ],
    );
  }

  Widget PlayUi() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (recordedFilePath != null)
            MaterialButton(
              onPressed: () async {
                if (audioPlayer.playing) {
                   audioPlayer.stop(); 
                           setState(() {
                              isPlaying=false;  
                           });
                } else {
                         await audioPlayer.setFilePath(recordedFilePath!);  
                         audioPlayer.play();
                         setState(() {
                   isPlaying=true;           
                           
                         });    

                }
              },
              child: isPlaying  ? Icon(Icons.pause) : Icon(Icons.play_arrow),
            )
          
        ],
      ),
    );
  }
}
