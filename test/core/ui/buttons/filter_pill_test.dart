import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FilterPill Widget Tests', () {
    testWidgets('renders label and handles tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FilterPill(
              label: 'Test Pill',
              isSelected: false,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Test Pill'), findsOneWidget);
      await tester.tap(find.byType(FilterPill));
      expect(tapped, isTrue);
    });

    testWidgets('shows icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FilterPill(
              label: 'Icon Pill',
              isSelected: false,
              onTap: () {},
              icon: Icons.check,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('applies selected styling when isSelected is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FilterPill(label: 'Selected', isSelected: true, onTap: () {}),
          ),
        ),
      );

      final animatedContainer = tester.widget<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      final decoration = animatedContainer.decoration as BoxDecoration;

      expect(decoration.color, equals(AppColors.primary));
    });
  });
}
