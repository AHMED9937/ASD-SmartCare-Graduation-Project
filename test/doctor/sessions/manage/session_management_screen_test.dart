import 'package:asdsmartcare/doctor/sessions/list/controllers/sessions_list_cubit.dart';
import 'package:asdsmartcare/doctor/sessions/list/controllers/sessions_list_state.dart';
import 'package:asdsmartcare/doctor/sessions/list/models/session_model.dart';
import 'package:asdsmartcare/doctor/sessions/manage/views/session_management_screen.dart';
import 'package:asdsmartcare/doctor/sessions/manage/views/widgets/feedback_card.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDoctorSessionListCubit extends MockCubit<GetDoctorSessionListStates>
    implements DoctorSessionListCubit {}

void main() {
  late MockDoctorSessionListCubit mockCubit;

  setUp(() {
    mockCubit = MockDoctorSessionListCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<DoctorSessionListCubit>.value(
        value: mockCubit,
        child: const SessionManagementView(sessionID: 'session_123'),
      ),
    );
  }

  testWidgets('renders loading state', (tester) async {
    when(() => mockCubit.state).thenReturn(GetSpecificSessionLoadingStates());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Loading session details...'), findsOneWidget);
  });

  testWidgets('renders error state', (tester) async {
    when(() => mockCubit.state).thenReturn(GetSpecificSessionFailedStates());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Failed to load session feedback.'), findsOneWidget);
  });

  testWidgets('renders empty state', (tester) async {
    when(() => mockCubit.state).thenReturn(GetSpecificSessionSuccessStates());
    when(() => mockCubit.selectedSession).thenReturn(Session(comments: []));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('No Feedback Yet'), findsOneWidget);
  });

  testWidgets('renders feedback list', (tester) async {
    final mockSession = Session(
      comments: ['Comment 1', 'Comment 2'],
      sessionDate: DateTime(2025, 12, 23),
    );

    when(() => mockCubit.state).thenReturn(GetSpecificSessionSuccessStates());
    when(() => mockCubit.selectedSession).thenReturn(mockSession);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(FeedbackCard), findsNWidgets(2));
    expect(find.text('Comment 1'), findsOneWidget);
    expect(find.text('Comment 2'), findsOneWidget);
  });
}
