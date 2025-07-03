import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;

class ReqFinalPredictionModel {
  final int index;
  final String ?answer;
  final MultipartFile? audioMp3;  // must be an .mp3 file

  ReqFinalPredictionModel({
    required this.index,
    required this.answer,
    this.audioMp3,
  });

  /// Build multipart/form-data body
  FormData toFormData() {
    return FormData.fromMap({
      'index': index.toString(),
      'answer': answer,
      if (answer == null) 'audio': audioMp3!,
    });
  }

  /// Helper to wrap a local .mp3 file into a MultipartFile
  static Future<MultipartFile> mp3FromFile(File file) async {
    final ext = p.extension(file.path).toLowerCase();
    if (ext != '.mp3') {
      throw ArgumentError('File must have .mp3 extension');
    }
    return MultipartFile.fromFile(
      file.path,
      filename: p.basename(file.path),
      contentType: MediaType('audio', 'mpeg'),
    );
  }
}
