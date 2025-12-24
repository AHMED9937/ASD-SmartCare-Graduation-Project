import 'package:asdsmartcare/doctor/clinic/views/widgets/day_selector_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DaySelectorStrip Widget Tests', () {
    final weekDays = ['Monday', 'Tuesday', 'Wednesday'];

    testWidgets('renders all days and highlights selected', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DaySelectorStrip(
            weekDays: weekDays,
            selectedDay: 'Monday',
            onDaySelected: (_) {},
            activeDays: const {'Tuesday': true},
          ),
        ),
      ));

      expect(find.text('Monday'), findsOneWidget);
      expect(find.text('Tuesday'), findsOneWidget);
      expect(find.text('Wednesday'), findsOneWidget);

      // Check for active icon on Tuesday
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('triggers callback on tap', (tester) async {
      String? result;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DaySelectorStrip(
            weekDays: weekDays,
            selectedDay: 'Monday',
            onDaySelected: (day) => result = day,
            activeDays: const {},
          ),
        ),
      ));

      await tester.tap(find.text('Tuesday'));
      expect(result, equals('Tuesday'));
    });
  });
}
