import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asdsmartcare/core/ui/badges/result_badge.dart';

void main() {
  group('ResultBadge', () {
    testWidgets('renders positive badge correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ResultBadge.positive(),
            ),
          ),
        ),
      );

      expect(find.text('No Signs Detected'), findsOneWidget);
      expect(find.byType(ResultBadge), findsOneWidget);
    });

    testWidgets('renders negative badge correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ResultBadge.negative(),
            ),
          ),
        ),
      );

      expect(find.text('Signs Detected'), findsOneWidget);
      expect(find.byType(ResultBadge), findsOneWidget);
    });

    testWidgets('renders level badge with level 1', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ResultBadge.level(level: 1),
            ),
          ),
        ),
      );

      expect(find.textContaining('Level 1'), findsOneWidget);
      expect(find.byType(ResultBadge), findsOneWidget);
    });

    testWidgets('renders level badge with level 2', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ResultBadge.level(level: 2),
            ),
          ),
        ),
      );

      expect(find.textContaining('Level 2'), findsOneWidget);
    });

    testWidgets('renders level badge with level 3', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ResultBadge.level(level: 3),
            ),
          ),
        ),
      );

      expect(find.textContaining('Level 3'), findsOneWidget);
    });

    testWidgets('renders custom badge with icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ResultBadge(
                icon: Icons.check_circle,
                label: 'Custom Badge',
                color: Colors.blue,
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('Custom Badge'), findsOneWidget);
    });

    testWidgets('positive badge shows check icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ResultBadge.positive(),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    });

    testWidgets('negative badge shows warning icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ResultBadge.negative(),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.warning_rounded), findsOneWidget);
    });

    testWidgets('level badge shows analytics icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ResultBadge.level(level: 1),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.analytics_rounded), findsOneWidget);
    });

    testWidgets('custom label overrides default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ResultBadge.positive(label: 'All Clear'),
            ),
          ),
        ),
      );

      expect(find.text('All Clear'), findsOneWidget);
    });

    group('responsive behavior', () {
      testWidgets('renders correctly on small screen', (tester) async {
        tester.view.physicalSize = const Size(320, 480);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: ResultBadge.positive(),
              ),
            ),
          ),
        );

        expect(find.byType(ResultBadge), findsOneWidget);
      });

      testWidgets('renders correctly on large screen', (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: ResultBadge.positive(),
              ),
            ),
          ),
        );

        expect(find.byType(ResultBadge), findsOneWidget);
      });
    });

    group('size variations', () {
      testWidgets('renders small size badge', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: ResultBadge.positive(size: ResultBadgeSize.small),
              ),
            ),
          ),
        );

        expect(find.byType(ResultBadge), findsOneWidget);
      });

      testWidgets('renders large size badge', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: ResultBadge.positive(size: ResultBadgeSize.large),
              ),
            ),
          ),
        );

        expect(find.byType(ResultBadge), findsOneWidget);
      });
    });
  });
}
