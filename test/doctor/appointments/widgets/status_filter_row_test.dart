import 'package:asdsmartcare/doctor/appointments/views/widgets/status_filter_row.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StatusFilterRow Widget Tests', () {
    testWidgets('renders all status pills', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: StatusFilterRow(
            selectedStatus: 'All',
            onStatusChanged: (_) {},
          ),
        ),
      ));

      expect(find.byType(FilterPill), findsNWidgets(3));
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Booked'), findsOneWidget);
      expect(find.text('Cancelled'), findsOneWidget);
    });

    testWidgets('tapping a pill triggers callback', (tester) async {
      String? result;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: StatusFilterRow(
            selectedStatus: 'All',
            onStatusChanged: (val) => result = val,
          ),
        ),
      ));

      await tester.tap(find.text('Booked'));
      expect(result, equals('Booked'));
    });
  });
}
