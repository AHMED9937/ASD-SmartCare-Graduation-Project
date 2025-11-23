import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_cubit.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_state.dart';
import 'package:asdsmartcare/parent/progress/views/progress_screen.dart';
import 'package:asdsmartcare/parent/progress/views/widgets/progress_overview_card.dart';
import 'package:asdsmartcare/parent/progress/views/widgets/doctor_navigation.dart';
import 'package:asdsmartcare/parent/progress/views/widgets/session_type_tabs.dart';
import 'package:asdsmartcare/parent/progress/views/widgets/session_card.dart';
import 'package:asdsmartcare/parent/progress/models/booked_doctors_model.dart';
import 'package:asdsmartcare/parent/progress/models/session_model.dart';
import 'package:asdsmartcare/parent/screening/history/models/test_level_model.dart';

class MockChildProgressCubit extends MockCubit<ChildProgressState>
    implements ChildProgressCubit {}

void main() {
  late MockChildProgressCubit mockCubit;

  setUp(() {
    mockCubit = MockChildProgressCubit();
  });

  Widget createWidget() {
    return MaterialApp(
      home: ChildProgressScreen(cubit: mockCubit),
    );
  }

  group('ChildProgressScreen Redesign Tests', () {
    testWidgets(
        'renders LoadingView when state is UnifiedProgressDataLoading and no data',
        (tester) async {
      when(() => mockCubit.state).thenReturn(UnifiedProgressDataLoading());
      when(() => mockCubit.myDoctorList).thenReturn(null);
      when(() => mockCubit.current).thenReturn(0);
      when(() => mockCubit.sessions).thenReturn([]);
      when(() => mockCubit.autismLevelHistory).thenReturn(null);
      when(() => mockCubit.GetAutismLevelTestHistory()).thenReturn(null);
      when(() => mockCubit.InitialFetchUnifiedData(any()))
          .thenAnswer((_) async {});

      await tester.pumpWidget(createWidget());
      expect(find.byType(LoadingView), findsOneWidget);
    });

    testWidgets('renders EmptyView when no doctors are available',
        (tester) async {
      when(() => mockCubit.state).thenReturn(UnifiedProgressDataLoaded());
      when(() => mockCubit.myDoctorList).thenReturn([]);
      when(() => mockCubit.current).thenReturn(0);
      when(() => mockCubit.sessions).thenReturn([]);
      when(() => mockCubit.autismLevelHistory).thenReturn(null);
      when(() => mockCubit.GetAutismLevelTestHistory()).thenReturn(null);
      when(() => mockCubit.InitialFetchUnifiedData(any()))
          .thenAnswer((_) async {});

      await tester.pumpWidget(createWidget());
      expect(find.text('No specialists booked yet.'), findsOneWidget);
    });

    testWidgets('renders DoctorNavigation and Sessions when data is present',
        (tester) async {
      final mockDoctors = [
        Doctors(id: '1', parent: Parent(userName: 'Dr. Smith')),
      ];
      final mockSessions = [
        SessionData(
            id: 's1', sessionNumber: 1, comments: ['Session 1 comment']),
      ];

      when(() => mockCubit.state).thenReturn(UnifiedProgressDataLoaded());
      when(() => mockCubit.myDoctorList).thenReturn(mockDoctors);
      when(() => mockCubit.current).thenReturn(0);
      when(() => mockCubit.sessions).thenReturn(mockSessions);
      when(() => mockCubit.GetAutismLevelTestHistory()).thenReturn(null);
      when(() => mockCubit.InitialFetchUnifiedData(any()))
          .thenAnswer((_) async {});

      // Mock some history to avoid the CTA in this 'present data' test
      when(() => mockCubit.autismLevelHistory)
          .thenReturn(HistoryAustisumLevelTest(
        status: 'success',
        data: [AustisumLevelTestData(output: Output(degreePrediction: 1))],
      ));

      await tester.pumpWidget(createWidget());

      expect(find.byType(ProgressOverviewCard), findsOneWidget);
      expect(find.byType(DoctorNavigation), findsOneWidget);
      expect(find.text('Dr. Smith'), findsOneWidget);
      expect(find.byType(SessionTypeTabs), findsOneWidget);
      expect(find.byType(SessionCard), findsOneWidget);
    });

    testWidgets('shows ErrorView when loading fails', (tester) async {
      when(() => mockCubit.state).thenReturn(UnifiedProgressDataError());
      when(() => mockCubit.myDoctorList).thenReturn(null);
      when(() => mockCubit.current).thenReturn(0);
      when(() => mockCubit.sessions).thenReturn([]);
      when(() => mockCubit.autismLevelHistory).thenReturn(null);
      when(() => mockCubit.GetAutismLevelTestHistory()).thenReturn(null);
      when(() => mockCubit.InitialFetchUnifiedData(any()))
          .thenAnswer((_) async {});

      await tester.pumpWidget(createWidget());
      expect(find.byType(ErrorView), findsOneWidget);
    });

    testWidgets('switching tabs triggers session fetch', (tester) async {
      final mockDoctors = [
        Doctors(id: '1', parent: Parent(userName: 'Dr. Smith')),
      ];
      when(() => mockCubit.state).thenReturn(UnifiedProgressDataLoaded());
      when(() => mockCubit.myDoctorList).thenReturn(mockDoctors);
      when(() => mockCubit.current).thenReturn(0);
      when(() => mockCubit.sessions).thenReturn([]);
      when(() => mockCubit.GetAllCommingSessionsBookedaSpecificParent(
          any(), any())).thenAnswer((_) async {});
      when(() => mockCubit.autismLevelHistory).thenReturn(null);
      when(() => mockCubit.GetAutismLevelTestHistory()).thenReturn(null);
      when(() => mockCubit.InitialFetchUnifiedData(any()))
          .thenAnswer((_) async {});

      await tester.pumpWidget(createWidget());

      // Tap "Upcoming Sessions" tab
      await tester.tap(find.text('Upcoming Sessions'));
      await tester.pump();

      verify(() =>
              mockCubit.GetAllCommingSessionsBookedaSpecificParent('1', true))
          .called(1);
    });
  });
}
