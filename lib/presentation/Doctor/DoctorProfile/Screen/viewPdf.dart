import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
/// Downloads the bytes at [url], saves them to a temp file,
/// renames that file to have a .pdf extension, and returns it.
Future<File> fetchRawAsPdf(String url) async {
  final res = await http.get(Uri.parse(url));
  if (res.statusCode != 200) {
    throw Exception('Failed to download file: HTTP ${res.statusCode}');
  }

  final dir = await getTemporaryDirectory();
  final rawPath = '${dir.path}/license_${DateTime.now().millisecondsSinceEpoch}';
  final rawFile = File(rawPath);
  await rawFile.writeAsBytes(res.bodyBytes, flush: true);

  final pdfFile = await rawFile.rename('$rawPath.pdf');
  return pdfFile;
}

class FileFetchAndOpenScreen extends StatefulWidget {
  final String rawUrl;
  const FileFetchAndOpenScreen({Key? key, required this.rawUrl}) : super(key: key);

  @override
  _FileFetchAndOpenScreenState createState() => _FileFetchAndOpenScreenState();
}

class _FileFetchAndOpenScreenState extends State<FileFetchAndOpenScreen> {
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchAndOpen();
  }

  Future<void> _fetchAndOpen() async {
    try {
      // 1) Download & rename
      final file = await fetchRawAsPdf(widget.rawUrl);
      // 2) Open in default viewer
      final result = await OpenFile.open(file.path);
      if (result.type != ResultType.done) {
        throw Exception('Could not open file: ${result.message}');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Fetching & Opening PDF')),
      body: PDF().cachedFromUrl(
             'https://ontheline.trincoll.edu/images/bookdown/sample-local-pdf.pdf',
             placeholder: (progress) => Center(child: Text('$progress %')),
             errorWidget: (error) => Center(child: Text(error.toString())),
           ),
    );
  }
}
