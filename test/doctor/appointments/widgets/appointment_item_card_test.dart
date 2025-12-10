import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/appointments/views/widgets/appointment_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  group('AppointmentItemCard Widget Tests', () {
    testWidgets('renders appointment details correctly', (tester) async {
      final appt = MockAppointmentData.sampleAppointment;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppointmentItemCard(appointment: appt)),
        ),
      );

      expect(find.text('10:00 AM'), findsOneWidget);
      expect(find.text('Monday'), findsOneWidget);
      expect(find.text('BOOKED'), findsOneWidget); // StatusBadge uppercases it
    });

    testWidgets('applies correct status color for booked', (tester) async {
      final appt = MockAppointmentData.sampleAppointment; // status: booked

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppointmentItemCard(appointment: appt)),
        ),
      );

      final badge = tester.widget<StatusBadge>(find.byType(StatusBadge));
      expect(badge.color, equals(AppColors.success));
    });

    testWidgets('applies correct status color for cancelled', (tester) async {
      final appt = MockAppointmentData.sampleAppointment;
      appt.status = 'cancelled';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppointmentItemCard(appointment: appt)),
        ),
      );

      final badge = tester.widget<StatusBadge>(find.byType(StatusBadge));
      expect(badge.color, equals(AppColors.error));
    });
  });
}
