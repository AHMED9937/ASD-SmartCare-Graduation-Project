import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/parent/chatbot/controllers/chatbot_cubit.dart';
import 'package:asdsmartcare/parent/chatbot/controllers/chatbot_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:asdsmartcare/core/cache/cache_helper.dart';

class MockDio extends Mock implements Dio {}

class FakeOptions extends Fake implements Options {}

void main() {
  late ChatBotCubit cubit;
  late MockDio mockDio;

  setUpAll(() async {
    registerFallbackValue(FakeOptions());
    SharedPreferences.setMockInitialValues({'token': 'fake_token'});
    await CacheHelper.init();
  });

  setUp(() {
    mockDio = MockDio();
    Diohelper.dio = mockDio;
    cubit = ChatBotCubit();
  });

  // tearDown removed to prevent double-dispose from blocTest

  group('ChatBotCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, isA<ChatBotInitial>());
      expect(cubit.messages.length, 1);
      expect(cubit.messages.first['isUser'], false);
    });

    blocTest<ChatBotCubit, ChatBotState>(
      'emits [ChatBotLoading, ChatBotSuccess] when sendMessage is successful',
      setUp: () {
        when(() => mockDio.post(
              any(),
              queryParameters: any(named: 'queryParameters'),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => Response(
              data: {
                'response': 'Hello, I am fine!',
                'session_id': 'test_session_id',
              },
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ));
      },
      build: () => cubit,
      act: (cubit) {
        cubit.questionController.text = 'How are you?';
        cubit.sendMessage();
      },
      expect: () => [
        isA<ChatBotLoading>(),
        isA<ChatBotSuccess>(),
      ],
      verify: (cubit) {
        expect(cubit.chatRes.response, 'Hello, I am fine!');
      },
    );

    blocTest<ChatBotCubit, ChatBotState>(
      'emits [ChatBotLoading, ChatBotError] when sendMessage fails',
      setUp: () {
        when(() => mockDio.post(
                  any(),
                  queryParameters: any(named: 'queryParameters'),
                  data: any(named: 'data'),
                  options: any(named: 'options'),
                ))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));
      },
      build: () => cubit,
      act: (cubit) {
        cubit.questionController.text = 'Error message';
        cubit.sendMessage();
      },
      expect: () => [
        isA<ChatBotLoading>(),
        isA<ChatBotError>(),
      ],
    );

    test('does not emit anything if question is empty', () async {
      cubit.questionController.text = '';
      cubit.sendMessage();
      expect(cubit.state, isA<ChatBotInitial>());
    });
  });
}
