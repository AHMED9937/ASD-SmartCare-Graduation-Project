import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/views/booking_screen.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/views/widgets/review_carousel.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/models/doctor_model.dart';
import 'package:asdsmartcare/parent/find_doctors/details/controllers/session_reviews_cubit.dart';
import 'package:asdsmartcare/parent/find_doctors/details/controllers/session_reviews_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSessionReviewsListCubit extends MockCubit<GetSessionReviewsListStates>
    implements SessionReviewsListCubit {}

void main() {
  late Doctor mockDoctor;

  setUp(() {
    mockDoctor = Doctor(
      id: 'doc-123',
      sessionPrice: 500,
      ratingsAverage: 4,
      qualifications: 'Highly qualified therapist with 10 years experience.',
      parent: Parent(userName: 'Dr. Sarah'),
      speciailization: 'Communication Specialist',
    );
  });

  Widget wrapInScaffold(Widget widget) {
    return MaterialApp(home: Scaffold(body: widget));
  }

  group('Booking Subwidgets Isolated Tests', () {
    testWidgets('DoctorProfileHeader renders doctor identity', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: DoctorProfileHeader(doctor: mockDoctor)),
        ),
      );

      expect(find.text('Dr. Sarah'), findsOneWidget);
      expect(find.text('Communication Specialist'), findsOneWidget);
      expect(find.byType(ProfileAvatar), findsOneWidget);
    });

    testWidgets('DoctorStats renders all 3 stat items', (tester) async {
      await tester.pumpWidget(wrapInScaffold(DoctorStats(doctor: mockDoctor)));

      expect(find.text('Experience'), findsOneWidget);
      expect(find.text('5+ Yrs'), findsOneWidget);
      expect(find.text('500 EGP'), findsOneWidget);
      // Using containing because of potential formatting/interpolation differences
      expect(find.textContaining('4'), findsOneWidget);
    });

    testWidgets('AboutSection renders qualifications content', (tester) async {
      await tester.pumpWidget(
        wrapInScaffold(
          const AboutSection(content: 'Specialized in ABA therapy'),
        ),
      );

      expect(find.text('Specialized in ABA therapy'), findsOneWidget);
    });

    testWidgets('BookingCard renders Calendar and TimeSlotGrid', (
      tester,
    ) async {
      final date = DateTime(2024, 1, 15);

      await tester.pumpWidget(
        wrapInScaffold(
          BookingCard(
            sortedDates: [date],
            effectiveDate: date,
            onDateSelected: (_) {},
            slots: const ['10:00 AM'],
            selectedSlot: null,
            onSlotSelected: (_) {},
            isBooking: false,
          ),
        ),
      );

      expect(find.byType(TimeSlotGrid), findsOneWidget);
      expect(find.text('10:00 AM'), findsOneWidget);
    });

    testWidgets('ReviewCarousel renders loading state', (tester) async {
      await tester.pumpWidget(
        wrapInScaffold(const ReviewCarousel(doctorId: 'doc-123')),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('Core Reusable Components (Booking specific)', () {
    testWidgets('TimeSlotGrid renders all slots and handles selection', (
      tester,
    ) async {
      final slots = ['9:00 AM', '10:00 AM', '11:00 AM'];
      String? selected;

      await tester.pumpWidget(
        wrapInScaffold(
          TimeSlotGrid(
            slots: slots,
            selectedSlot: null,
            onSlotSelected: (val) => selected = val,
          ),
        ),
      );

      expect(find.text('9:00 AM'), findsOneWidget);
      expect(find.text('11:00 AM'), findsOneWidget);

      await tester.tap(find.text('10:00 AM'));
      expect(selected, equals('10:00 AM'));
    });
  });
}
