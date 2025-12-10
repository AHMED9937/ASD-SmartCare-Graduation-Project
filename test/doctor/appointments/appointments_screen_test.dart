import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/appointments/controllers/appointments_cubit.dart';
import 'package:asdsmartcare/doctor/appointments/controllers/appointments_state.dart';
import 'package:asdsmartcare/doctor/appointments/views/appointments_screen.dart';
import 'package:asdsmartcare/doctor/appointments/views/widgets/appointment_item_card.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'test_helpers.dart';

class MockDoctorAppointmentListCubit
    extends MockCubit<GetDoctorAppointmentListStates>
    implements DoctorAppointmentListCubit {}

void main() {
  late MockDoctorAppointmentListCubit mockCubit;

  setUp(() {
    mockCubit = MockDoctorAppointmentListCubit();
    // Default behaviors
    when(() => mockCubit.appointments).thenReturn(null);
    when(
      () => mockCubit.fetchAppointments(status: any(named: 'status')),
    ).thenAnswer((_) async {});
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(home: AppointmentListScreen(cubit: mockCubit));
  }

  group('AppointmentListScreen Widget Tests', () {
    testWidgets('renders LoadingView when state is Loading', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(GetDoctorAppointmentListLoadingStates());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(LoadingView), findsOneWidget);
    });

    testWidgets('renders ErrorView when state is Failed', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(GetDoctorAppointmentListFailedStates());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ErrorView), findsOneWidget);
      expect(find.text('Failed to load appointments'), findsOneWidget);
    });

    testWidgets('renders EmptyView when no appointments found', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(GetDoctorAppointmentListSuccessStates());
      when(
        () => mockCubit.appointments,
      ).thenReturn(MockAppointmentData.emptyResponse);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(EmptyView), findsOneWidget);
      expect(find.text('No Appointments'), findsOneWidget);
    });

    testWidgets('renders list of appointments on success', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(GetDoctorAppointmentListSuccessStates());
      when(
        () => mockCubit.appointments,
      ).thenReturn(MockAppointmentData.sampleResponse);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(AppointmentItemCard), findsOneWidget);
      expect(find.text('10:00 AM'), findsOneWidget);
      expect(find.text('BOOKED'), findsOneWidget);
    });

    testWidgets('StatusFilterRow interaction triggers fetchAppointments', (
      tester,
    ) async {
      when(
        () => mockCubit.state,
      ).thenReturn(GetDoctorAppointmentListSuccessStates());
      when(
        () => mockCubit.appointments,
      ).thenReturn(MockAppointmentData.sampleResponse);

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Cancelled'));
      await tester.pump();

      verify(() => mockCubit.fetchAppointments(status: 'cancelled')).called(1);
    });

    testWidgets('ResponsiveContainer uses mobile layout on small screens', (
      tester,
    ) async {
      when(
        () => mockCubit.state,
      ).thenReturn(GetDoctorAppointmentListSuccessStates());
      when(
        () => mockCubit.appointments,
      ).thenReturn(MockAppointmentData.sampleResponse);

      tester.view.physicalSize = const Size(400 * 3, 800 * 3);
      tester.view.devicePixelRatio = 3.0;

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(AppointmentsOverviewBody), findsOneWidget);

      // Reset
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}
