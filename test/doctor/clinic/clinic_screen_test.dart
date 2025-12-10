import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/clinic/controllers/clinic_cubit.dart';
import 'package:asdsmartcare/doctor/clinic/controllers/clinic_state.dart';
import 'package:asdsmartcare/doctor/clinic/views/clinic_screen.dart';
import 'package:asdsmartcare/doctor/clinic/views/widgets/clinic_overview_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'test_helpers.dart';

class MockAvailabilityCubit extends MockCubit<AvailabilityState>
    implements AvailabilityCubit {}

void main() {
  late MockAvailabilityCubit mockCubit;

  setUp(() {
    mockCubit = MockAvailabilityCubit();
    when(() => mockCubit.availabilityDays).thenReturn(null);
    when(() => mockCubit.getDocAvailability()).thenAnswer((_) async {});
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(home: ClinicDoctorScreen(cubit: mockCubit));
  }

  group('ClinicDoctorScreen Widget Tests', () {
    testWidgets(
      'renders LoadingView when state is GetDoctorAvailabilityLoading',
      (tester) async {
        when(() => mockCubit.state).thenReturn(GetDoctorAvailabilityLoading());

        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byType(LoadingView), findsOneWidget);
      },
    );

    testWidgets('renders ErrorView when state is GetDoctorAvailabilityError', (
      tester,
    ) async {
      when(
        () => mockCubit.state,
      ).thenReturn(const GetDoctorAvailabilityError('Failed'));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ErrorView), findsOneWidget);
      expect(find.text('Failed to load clinic settings'), findsOneWidget);
    });

    testWidgets('renders ClinicOverviewBody on success', (tester) async {
      when(() => mockCubit.state).thenReturn(
        GetDoctorAvailabilitySuccess(
          model: MockAvailabilityData.sampleResponse,
        ),
      );
      when(
        () => mockCubit.availabilityDays,
      ).thenReturn(MockAvailabilityData.sampleResponse);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(ClinicOverviewBody), findsOneWidget);
      expect(find.byType(PageHeader), findsOneWidget);
    });
  });
}
