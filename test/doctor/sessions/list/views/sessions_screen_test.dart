import 'package:asdsmartcare/doctor/sessions/list/controllers/sessions_list_cubit.dart';
import 'package:asdsmartcare/doctor/sessions/list/controllers/sessions_list_state.dart';
import 'package:asdsmartcare/doctor/sessions/list/views/sessions_screen.dart';
import 'package:asdsmartcare/doctor/sessions/list/models/session_model.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
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
    // Default behavior
    when(
      () => mockCubit.fetchSessions(status: any(named: 'status')),
    ).thenAnswer((_) async {});
    when(() => mockCubit.sessions).thenReturn(SessionsResponse(data: []));
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<DoctorSessionListCubit>.value(
        value: mockCubit,
        child: const SessionsView(status: 'upcoming'),
      ),
    );
  }

  group('SessionsScreen', () {
    testWidgets('renders LoadingView when state is loading', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(GetDoctorSessionListLoadingStates());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(LoadingView), findsOneWidget);
    });

    testWidgets('renders ErrorView when state is failed', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(GetDoctorSessionListFailedStates());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ErrorView), findsOneWidget);
    });

    testWidgets('renders EmptyView when sessions list is empty', (
      tester,
    ) async {
      when(
        () => mockCubit.state,
      ).thenReturn(GetDoctorSessionListSuccessStates());
      when(() => mockCubit.sessions).thenReturn(SessionsResponse(data: []));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(EmptyView), findsOneWidget);
      expect(find.text('No upcoming sessions'), findsOneWidget);
    });

    testWidgets('renders list of sessions when data is present', (
      tester,
    ) async {
      final sessions = [
        Session(
          id: '1',
          parent: ParentData(
            userName: 'Parent 1',
            childs: [Child(childName: 'Child 1', age: '4', gender: 'Male')],
          ),
          createdAt: DateTime.now(),
        ),
      ];
      when(
        () => mockCubit.state,
      ).thenReturn(GetDoctorSessionListSuccessStates());
      when(
        () => mockCubit.sessions,
      ).thenReturn(SessionsResponse(data: sessions));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Child 1'), findsOneWidget);
      expect(find.text('4 years • Male'), findsOneWidget);
    });
  });
}
