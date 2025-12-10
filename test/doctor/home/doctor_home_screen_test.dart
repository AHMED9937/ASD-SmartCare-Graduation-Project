import 'package:asdsmartcare/doctor/home/views/widgets/quick_action_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DoctorHomeScreen Widget Tests', () {
    testWidgets(
      'QuickActionCard renders correctly with all required elements',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 400,
                  height: 300,
                  child: QuickActionCard(
                    icon: Icons.notifications_active_outlined,
                    title: 'Upcoming Sessions',
                    subtitle: 'Manage today and tomorrow\'s schedule',
                    onTap: () {},
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Verify the card renders with correct content
        expect(find.byType(QuickActionCard), findsOneWidget);
        expect(find.text('Upcoming Sessions'), findsOneWidget);
        expect(
          find.text('Manage today and tomorrow\'s schedule'),
          findsOneWidget,
        );
        expect(find.text('Access'), findsOneWidget);
        expect(
          find.byIcon(Icons.notifications_active_outlined),
          findsOneWidget,
        );
      },
    );

    testWidgets('QuickActionCard is tappable', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                height: 220,
                child: QuickActionCard(
                  icon: Icons.task_alt_rounded,
                  title: 'Test Title',
                  subtitle: 'Test Subtitle',
                  onTap: () => tapped = true,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(QuickActionCard));
      expect(tapped, isTrue);
    });
  });
}
