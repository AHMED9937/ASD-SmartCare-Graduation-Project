import 'package:asdsmartcare/parent/home/widgets/care_pulse_card.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_cubit.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_state.dart';
import 'package:asdsmartcare/parent/progress/models/session_model.dart' as sm;
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChildProgressCubit extends MockCubit<ChildProgressState>
    implements ChildProgressCubit {}

void main() {
  late MockChildProgressCubit mockCubit;

  setUp(() {
    mockCubit = MockChildProgressCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<ChildProgressCubit>.value(
          value: mockCubit,
          child: const CarePulseCard(),
        ),
      ),
    );
  }

  testWidgets('renders booking CTA when no sessions', (tester) async {
    when(() => mockCubit.sessions).thenReturn([]);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('START YOUR JOURNEY'), findsOneWidget);
    expect(find.text('Book Now'), findsOneWidget);
  });

  testWidgets('renders session details when sessions exist', (tester) async {
    final session = sm.SessionData(
      sessionDate: '2024-12-25',
      doctorId: sm.Doctor(parent: sm.ParentInfo(userName: 'Dr. Smith')),
    );
    when(() => mockCubit.sessions).thenReturn([session]);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('UPCOMING SESSION'), findsOneWidget);
    expect(find.text('Session with Dr. Smith'), findsOneWidget);
    expect(find.text('2024-12-25'), findsOneWidget);
    expect(find.text('View Details'), findsOneWidget);
  });
}
