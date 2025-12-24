import 'dart:async';
import 'dart:io';
import 'package:asdsmartcare/shared/donations/models/charity_model.dart';
import 'package:asdsmartcare/shared/donations/views/charity_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => _MockHttpClient();
}

class _MockHttpClient extends Mock implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) =>
      Future.value(_MockHttpClientRequest());

  @override
  set autoUncompress(bool value) {}
}

class _MockHttpClientRequest extends Mock implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() => Future.value(_MockHttpClientResponse());
}

class _MockHttpClientResponse extends Mock implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => 0;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(void Function(List<int> event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return Stream<List<int>>.fromIterable([
      [
        71,
        73,
        70,
        56,
        57,
        97,
        1,
        0,
        1,
        0,
        128,
        0,
        0,
        0,
        0,
        0,
        255,
        255,
        255,
        33,
        249,
        4,
        1,
        0,
        0,
        0,
        0,
        44,
        0,
        0,
        0,
        0,
        1,
        0,
        1,
        0,
        0,
        2,
        1,
        68,
        0,
        59
      ]
    ]).listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = TestHttpOverrides();
  });

  final mockCharity = Charity(
    id: '1',
    charityName: 'Helping Hands',
    charityAddress: '123 Charity St',
    charityPhone: '555-0199',
    logo: 'https://example.com/logo.png',
    charityMedican: [
      CharityMedicine(medicanName: 'Aspirin'),
    ],
  );

  testWidgets('renders CharityInfo with correct data', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CharityInfo(charityData: mockCharity),
    ));

    expect(find.text('Helping Hands'), findsOneWidget);
    expect(find.text('123 Charity St'), findsOneWidget);
    expect(find.text('555-0199'), findsOneWidget);
    expect(find.text('Make a Donation'), findsOneWidget);
    expect(find.text('Credit Card / E-wallet'), findsOneWidget);
    expect(find.text('Cash at Charity'), findsOneWidget);
    expect(find.text('Donate Now'), findsOneWidget);
  });
}
