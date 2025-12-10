import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/controllers/booking_cubit.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/controllers/booking_state.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/data/booking_repository.dart'
    as repo;
import 'package:asdsmartcare/parent/find_doctors/booking/views/booking_screen.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/views/widgets/review_carousel.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/models/doctor_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBookingCubit extends MockCubit<BookingState>
    implements BookingCubit {}

void main() {
  setUpAll(() {
    Diohelper.init();
  });

  late MockBookingCubit mockCubit;
  late Doctor mockDoctor;
  final mockDate = DateTime(2024, 1, 15);

  setUp(() {
    mockCubit = MockBookingCubit();
    mockDoctor = Doctor(
      id: 'doc-123',
      sessionPrice: 500,
      ratingsAverage: 4,
      qualifications: 'Expert in Autism',
      parent: Parent(userName: 'Dr. Ahmed'),
      speciailization: 'Behavioral Therapist',
    );

    // Default mock behavior
    when(() => mockCubit.selectableDates).thenReturn({});
    when(() => mockCubit.getSlotsForDate(any())).thenReturn([]);
    when(
      () => mockCubit.getDoctorsAppointments(any()),
    ).thenAnswer((_) async {});
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: SizedBox(
        width: 400,
        height: 800,
        child: Reservationscreen(myDoctor: mockDoctor, cubit: mockCubit),
      ),
    );
  }

  group('Reservationscreen Widget Tests', () {
    testWidgets('renders LoadingView when state is SlotsLoading', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(const SlotsLoading());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(LoadingView), findsOneWidget);
    });

    testWidgets('renders ErrorView when state is SlotsError', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(const SlotsError(message: 'Something went wrong'));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ErrorView), findsOneWidget);
    });

    testWidgets('renders EmptyView when state is NoSlotsAvailable', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(const NoSlotsAvailable());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(EmptyView), findsOneWidget);
    });

    testWidgets('renders BookingBody in success state', (tester) async {
      // Mocking SlotsLoaded with an empty AvailableSlots object (assuming map is the arg)
      when(
        () => mockCubit.state,
      ).thenReturn(const SlotsLoaded(repo.AvailableSlots({})));
      when(() => mockCubit.selectableDates).thenReturn({mockDate});
      when(() => mockCubit.getSlotsForDate(any())).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(BookingBody), findsOneWidget);
      expect(find.byType(AppHeader), findsOneWidget);
      expect(find.byType(DoctorProfileHeader), findsOneWidget);
      expect(find.byType(DoctorStats), findsOneWidget);
      expect(find.byType(ReviewCarousel), findsOneWidget);
    });

    testWidgets('Hero animation tag is correctly applied to avatar', (
      tester,
    ) async {
      when(
        () => mockCubit.state,
      ).thenReturn(const SlotsLoaded(repo.AvailableSlots({})));
      when(() => mockCubit.selectableDates).thenReturn({mockDate});

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final heroFinder = find.byType(Hero);
      expect(heroFinder, findsOneWidget);

      final heroWidget = tester.widget<Hero>(heroFinder);
      expect(heroWidget.tag, equals('doctor_avatar_doc-123'));
    });

    testWidgets('Book Now button has correct accessibility labels', (
      tester,
    ) async {
      when(
        () => mockCubit.state,
      ).thenReturn(const SlotsLoaded(repo.AvailableSlots({})));
      when(() => mockCubit.selectableDates).thenReturn({mockDate});

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Confirm booking button'), findsOneWidget);
    });
  });
}
