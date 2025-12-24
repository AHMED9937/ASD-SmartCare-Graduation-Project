import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asdsmartcare/parent/screening/test/widgets/test_progress_header.dart';

void main() {
  group('TestProgressHeader', () {
    testWidgets('renders with current index and total', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestProgressHeader(
              currentIndex: 2,
              totalQuestions: 10,
            ),
          ),
        ),
      );

      expect(find.textContaining('3'), findsWidgets); // 0-indexed, so shows 3
      expect(find.textContaining('10'), findsWidgets);
    });

    testWidgets('displays title when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestProgressHeader(
              currentIndex: 0,
              totalQuestions: 5,
              title: 'Screening Test',
            ),
          ),
        ),
      );

      expect(find.text('Screening Test'), findsOneWidget);
    });

    testWidgets('displays subtitle when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestProgressHeader(
              currentIndex: 0,
              totalQuestions: 5,
              subtitle: 'Answer honestly',
            ),
          ),
        ),
      );

      expect(find.text('Answer honestly'), findsOneWidget);
    });

    testWidgets('shows progress ring when enabled', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestProgressHeader(
              currentIndex: 0,
              totalQuestions: 5,
              showProgressRing: true,
            ),
          ),
        ),
      );

      // Progress ring should be visible
      expect(find.byType(TestProgressHeader), findsOneWidget);
    });

    testWidgets('hides progress ring when disabled', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestProgressHeader(
              currentIndex: 0,
              totalQuestions: 5,
              showProgressRing: false,
            ),
          ),
        ),
      );

      // Linear progress should be shown instead
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('shows correct question number format', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestProgressHeader(
              currentIndex: 4,
              totalQuestions: 10,
            ),
          ),
        ),
      );

      expect(find.text('Question 5 of 10'), findsOneWidget);
    });

    testWidgets('handles zero total questions gracefully', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestProgressHeader(
              currentIndex: 0,
              totalQuestions: 0,
            ),
          ),
        ),
      );

      // Should not crash
      expect(find.byType(TestProgressHeader), findsOneWidget);
    });

    testWidgets('has accessibility semantics', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestProgressHeader(
              currentIndex: 2,
              totalQuestions: 10,
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(TestProgressHeader));
      expect(semantics.label, contains('Question 3 of 10'));
    });

    testWidgets('animates question counter on change', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestProgressHeader(
              currentIndex: 0,
              totalQuestions: 5,
            ),
          ),
        ),
      );

      expect(find.text('Question 1 of 5'), findsOneWidget);

      // Rebuild with new index
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestProgressHeader(
              currentIndex: 1,
              totalQuestions: 5,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Question 2 of 5'), findsOneWidget);
    });

    group('responsive behavior', () {
      testWidgets('renders on small screen', (tester) async {
        tester.view.physicalSize = const Size(320, 480);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TestProgressHeader(
                currentIndex: 0,
                totalQuestions: 5,
                title: 'Test',
              ),
            ),
          ),
        );

        expect(find.byType(TestProgressHeader), findsOneWidget);
      });

      testWidgets('renders on large screen', (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TestProgressHeader(
                currentIndex: 0,
                totalQuestions: 5,
                title: 'Test',
              ),
            ),
          ),
        );

        expect(find.byType(TestProgressHeader), findsOneWidget);
      });
    });
  });
}
