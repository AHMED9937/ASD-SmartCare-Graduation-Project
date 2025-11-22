import 'dart:async';
import 'dart:io';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/donations/controllers/charity_cubit.dart';
import 'package:asdsmartcare/shared/donations/controllers/charity_state.dart';
import 'package:asdsmartcare/shared/donations/models/charity_model.dart';
import 'package:asdsmartcare/shared/donations/views/charities_screen.dart'
    as views;
import 'package:asdsmartcare/shared/donations/views/widgets/charity_card.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAvailableCharityCubit extends MockCubit<AvailableCharityState>
    implements AvailableCharityCubit {}

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
  late MockAvailableCharityCubit mockCubit;

  setUpAll(() {
    HttpOverrides.global = TestHttpOverrides();
  });

  setUp(() {
    mockCubit = MockAvailableCharityCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: views.CharityMedicine(cubit: mockCubit),
    );
  }

  final mockCharities = [
    Charity(
      id: '1',
      charityName: 'Helping Hands',
      charityAddress: '123 Charity St',
      logo: 'https://example.com/logo.png',
      charityMedican: [
        CharityMedicine(medicanName: 'Aspirin'),
      ],
    ),
  ];

  testWidgets('renders CharityMedicine with loading state', (tester) async {
    when(() => mockCubit.state).thenReturn(GetAvailableCharityLoading());
    when(() => mockCubit.items).thenReturn([]);
    when(() => mockCubit.getAvailableCharity()).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(LoadingView), findsOneWidget);
  });

  testWidgets('renders CharityMedicine with success state and items',
      (tester) async {
    when(() => mockCubit.state).thenReturn(
        GetAvailableCharitySuccess(CharityResponse(data: mockCharities)));
    when(() => mockCubit.items).thenReturn(mockCharities);
    when(() => mockCubit.getAvailableCharity()).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Helping Hands'), findsOneWidget);
    expect(find.text('123 Charity St'), findsOneWidget);
    expect(find.byType(CharityCard), findsOneWidget);
  });

  testWidgets('renders CharityMedicine with empty state', (tester) async {
    when(() => mockCubit.state)
        .thenReturn(GetAvailableCharitySuccess(CharityResponse(data: [])));
    when(() => mockCubit.items).thenReturn([]);
    when(() => mockCubit.getAvailableCharity()).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(EmptyView), findsOneWidget);
    expect(find.text('No charities found in this area.'), findsOneWidget);
  });

  testWidgets('renders CharityMedicine with error state', (tester) async {
    when(() => mockCubit.state)
        .thenReturn(GetAvailableCharityError('Error message'));
    when(() => mockCubit.items).thenReturn([]);
    when(() => mockCubit.getAvailableCharity()).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(ErrorView), findsOneWidget);
    expect(find.text('Error message'), findsOneWidget);
  });
}
