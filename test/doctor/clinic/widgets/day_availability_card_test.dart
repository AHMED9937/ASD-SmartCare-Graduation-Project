import 'package:asdsmartcare/doctor/clinic/views/widgets/day_availability_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DayAvailabilityCard Widget Tests', () {
    testWidgets('renders days and toggle', (tester) async {
      bool toggleCalled = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DayAvailabilityCard(
            day: 'Monday',
            isActive: false,
            selectedDate: null,
            selectedTimes: const [],
            onToggleActive: () => toggleCalled = true,
            onPickDate: () {},
            onAddTime: () {},
            onDeleteTime: (_) {},
          ),
        ),
      ));

      expect(find.text('Monday'), findsOneWidget);
      await tester.tap(find.byType(Switch));
      expect(toggleCalled, isTrue);
    });

    testWidgets('renders details when active', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DayAvailabilityCard(
            day: 'Monday',
            isActive: true,
            selectedDate: DateTime(2023, 12, 25),
            selectedTimes: const [TimeOfDay(hour: 10, minute: 0)],
            onToggleActive: () {},
            onPickDate: () {},
            onAddTime: () {},
            onDeleteTime: (_) {},
          ),
        ),
      ));

      expect(find.text('2023-12-25'), findsOneWidget);
      expect(find.text('10:00 AM'), findsOneWidget);
      expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    });
  });
}
