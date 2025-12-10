import 'package:asdsmartcare/core/ui/containers/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SectionHeader Widget Tests', () {
    testWidgets('renders title correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SectionHeader(title: 'Test Section')),
        ),
      );

      expect(find.text('Test Section'), findsOneWidget);
      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('renders action button when actionLabel is provided', (
      tester,
    ) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'Test Section',
              actionLabel: 'View All',
              onActionPressed: () => pressed = true,
            ),
          ),
        ),
      );

      expect(find.text('View All'), findsOneWidget);
      await tester.tap(find.byType(TextButton));
      expect(pressed, isTrue);
    });

    testWidgets('applies custom padding', (tester) async {
      const customPadding = EdgeInsets.all(32);
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(title: 'Test Section', padding: customPadding),
          ),
        ),
      );

      final paddingWidget = tester.widget<Padding>(find.byType(Padding));
      expect(paddingWidget.padding, customPadding);
    });
  });
}
