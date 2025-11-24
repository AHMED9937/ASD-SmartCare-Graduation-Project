import 'package:asdsmartcare/doctor/home/views/widgets/quick_action_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuickActionCard Widget Tests', () {
    testWidgets('renders icon, title, and subtitle correctly', (tester) async {
      const title = 'Test Title';
      const subtitle = 'Test Subtitle';
      const icon = Icons.add;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: QuickActionCard(
            icon: icon,
            title: title,
            subtitle: subtitle,
            onTap: () {},
          ),
        ),
      ));

      expect(find.text(title), findsOneWidget);
      expect(find.text(subtitle), findsOneWidget);
      expect(find.byIcon(icon), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_rounded), findsOneWidget);
    });

    testWidgets('triggers onTap callback', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: QuickActionCard(
            icon: Icons.add,
            title: 'Title',
            subtitle: 'Subtitle',
            onTap: () => tapped = true,
          ),
        ),
      ));

      await tester.tap(find.byType(QuickActionCard));
      expect(tapped, isTrue);
    });
  });
}
