import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/home/views/doctor_home_screen.dart';
import 'package:asdsmartcare/doctor/home/views/widgets/quick_action_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DoctorHomeScreen Widget Tests', () {
    testWidgets('renders PageHeader, DailyOverview, and QuickActionCards',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(
        home: DoctorHomeScreen(),
      ));
      await tester.pumpAndSettle();

      try {
        expect(find.byType(PageHeader), findsOneWidget);
        expect(find.text('Welcome Back,'), findsOneWidget);
        expect(find.text('Daily Overview'), findsOneWidget);
        expect(find.byType(StatItem), findsNWidgets(3));
        expect(find.byType(QuickActionCard), findsNWidgets(4));
      } catch (e) {
        print('Test failed error: $e');
        print('Found Text widgets:');
        for (final widget in tester.allWidgets.whereType<Text>()) {
          print(' - "${widget.data}"');
        }
        rethrow;
      } finally {
        tester.view.resetPhysicalSize();
      }
    });

    testWidgets('displays correct actions in the grid', (tester) async {
      tester.view.physicalSize = const Size(1200, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(
        home: DoctorHomeScreen(),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Upcoming Sessions'), findsOneWidget);
      expect(find.text('Completed Sessions'), findsOneWidget);
      expect(find.text('New Session'), findsOneWidget);
      expect(find.text('Appointment List'), findsOneWidget);

      tester.view.resetPhysicalSize();
    });
  });
}
