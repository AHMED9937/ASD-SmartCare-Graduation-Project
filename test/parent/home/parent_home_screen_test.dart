import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/controllers/doctors_list_cubit.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/controllers/doctors_list_state.dart';
import 'package:asdsmartcare/parent/home/parent_home_screen.dart';
import 'package:asdsmartcare/parent/home/widgets/care_pulse_card.dart';
import 'package:asdsmartcare/parent/home/widgets/recommended_doctors_section.dart';
import 'package:asdsmartcare/parent/home/widgets/service_orbit.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_cubit.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mocks
class MockChildProgressCubit extends MockCubit<ChildProgressState>
    implements ChildProgressCubit {}

class MockDoctorsListCubit extends MockCubit<GetDoctorsListStates>
    implements DoctorsListCubit {}

void main() {
  late MockChildProgressCubit mockProgressCubit;
  late MockDoctorsListCubit mockDoctorsCubit;

  setUp(() async {
    mockProgressCubit = MockChildProgressCubit();
    mockDoctorsCubit = MockDoctorsListCubit();

    SharedPreferences.setMockInitialValues({
      'id': 'user_123',
      'userName': 'Ahmed',
    });
    await CacheHelper.init();

    // Default Stubs
    when(() => mockProgressCubit.state).thenReturn(ChildProgressInitial());
    when(() => mockProgressCubit.sessions).thenReturn([]);
    when(() => mockProgressCubit.getAllUpcomingSessionsForParent(
        any<String>(), any<bool>())).thenReturn(null);

    when(() => mockDoctorsCubit.state).thenReturn(GetDoctorsListInitialState());
    when(() => mockDoctorsCubit.myDoctorList).thenReturn([]);
    when(() => mockDoctorsCubit.getDoctorsList(
            recommendedDoctor: any<bool>(named: 'recommendedDoctor')))
        .thenAnswer((_) async {});
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ChildProgressCubit>.value(value: mockProgressCubit),
          BlocProvider<DoctorsListCubit>.value(value: mockDoctorsCubit),
        ],
        child: ParentHomeScreen(doctorsCubit: mockDoctorsCubit),
      ),
    );
  }

  testWidgets('Renders ParentHomeScreen with all sections', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(seconds: 1));

    // Verify Greeting
    expect(find.textContaining('Hello,'), findsOneWidget);

    // Verify CarePulseCard
    expect(find.byType(CarePulseCard), findsOneWidget);

    // Verify Section Headers
    expect(find.text('Quick Services'), findsOneWidget);
    expect(find.text('Top Specialists'), findsOneWidget);

    // Verify Service Orbit
    expect(find.byType(ServiceOrbit), findsOneWidget);
    expect(find.text('AI Test'), findsOneWidget);

    // Verify Recommended Doctors Section
    expect(find.byType(RecommendedDoctorsSection), findsOneWidget);
  });

  testWidgets('Responsive check: no overflows on small screen', (tester) async {
    tester.view.physicalSize = const Size(320, 600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(seconds: 1));

    expect(tester.takeException(), isNull);
  });

  testWidgets('Responsive check: no overflows on tablet screen',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(seconds: 1));

    expect(tester.takeException(), isNull);
  });
}
