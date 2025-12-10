import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/chatbot/controllers/chatbot_cubit.dart';
import 'package:asdsmartcare/parent/chatbot/controllers/chatbot_state.dart';
import 'package:asdsmartcare/parent/chatbot/views/chat_screen.dart';
import 'package:asdsmartcare/parent/chatbot/views/widgets/chat_input_dock.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatBotCubit extends MockCubit<ChatBotState>
    implements ChatBotCubit {}

void main() {
  late MockChatBotCubit mockCubit;

  setUp(() {
    mockCubit = MockChatBotCubit();
    when(() => mockCubit.messages).thenReturn([
      {'message': 'Hello!', 'isUser': false},
    ]);
    when(
      () => mockCubit.questionController,
    ).thenReturn(TextEditingController());
    when(() => mockCubit.close()).thenAnswer((_) async {});
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(home: ChatBotscreen(cubit: mockCubit));
  }

  group('ChatBotscreen Widget Tests', () {
    testWidgets('renders initial state with bot message', (tester) async {
      when(() => mockCubit.state).thenReturn(ChatBotInitial());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('AI Companion'), findsOneWidget);
      expect(find.text('Hello!'), findsOneWidget);
      expect(find.byType(ChatInputDock), findsOneWidget);
    });

    testWidgets('renders typing indicator when loading', (tester) async {
      when(() => mockCubit.state).thenReturn(ChatBotLoading());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(BotTypingIndicator), findsOneWidget);
    });

    testWidgets('user can type and send message', (tester) async {
      when(() => mockCubit.state).thenReturn(ChatBotInitial());
      when(() => mockCubit.sendMessage()).thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextField), 'Test question');
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();

      verify(() => mockCubit.sendMessage()).called(1);
    });

    testWidgets('shows snackbar on error', (tester) async {
      whenListen(
        mockCubit,
        Stream.fromIterable([ChatBotLoading(), ChatBotError()]),
        initialState: ChatBotInitial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle(); // Allow SnackBar to animate in

      expect(find.text('Failed to connect. Please try again.'), findsOneWidget);
    });

    testWidgets('responsive layout on tablet width', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      when(() => mockCubit.state).thenReturn(ChatBotInitial());
      await tester.pumpWidget(createWidgetUnderTest());

      // Should find ResponsivePadding which handles tablet width
      expect(find.byType(ResponsivePadding), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });
  });
}
