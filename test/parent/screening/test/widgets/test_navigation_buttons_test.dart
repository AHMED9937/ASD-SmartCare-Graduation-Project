import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asdsmartcare/parent/screening/test/widgets/test_navigation_buttons.dart';

void main() {
  group('TestNavigationButtons', () {
    testWidgets('renders next button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: TestNavigationButtons(onNext: () {})),
        ),
      );

      expect(find.text('Next Question'), findsOneWidget);
    });

    testWidgets('triggers onNext when next button is pressed', (tester) async {
      var nextPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TestNavigationButtons(onNext: () => nextPressed = true),
          ),
        ),
      );

      await tester.tap(find.text('Next Question'));
      await tester.pumpAndSettle();

      expect(nextPressed, isTrue);
    });

    testWidgets('shows previous button when showPrevious is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TestNavigationButtons(
              onNext: () {},
              onPrevious: () {},
              showPrevious: true,
            ),
          ),
        ),
      );

      expect(find.text('Previous'), findsOneWidget);
    });

    testWidgets('hides previous button when showPrevious is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TestNavigationButtons(onNext: () {}, showPrevious: false),
          ),
        ),
      );

      expect(find.text('Previous'), findsNothing);
    });

    testWidgets('triggers onPrevious when previous button is pressed', (
      tester,
    ) async {
      var prevPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TestNavigationButtons(
              onNext: () {},
              onPrevious: () => prevPressed = true,
              showPrevious: true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Previous'));
      await tester.pumpAndSettle();

      expect(prevPressed, isTrue);
    });

    testWidgets('shows "Complete Test" label on last question', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TestNavigationButtons(onNext: () {}, isLastQuestion: true),
          ),
        ),
      );

      expect(find.text('Complete Test'), findsOneWidget);
    });

    testWidgets('shows loading indicator when isLoading is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TestNavigationButtons(onNext: () {}, isLoading: true),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('uses custom next label when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TestNavigationButtons(onNext: () {}, nextLabel: 'Continue'),
          ),
        ),
      );

      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('uses custom previous label when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TestNavigationButtons(
              onNext: () {},
              onPrevious: () {},
              showPrevious: true,
              previousLabel: 'Go Back',
            ),
          ),
        ),
      );

      expect(find.text('Go Back'), findsOneWidget);
    });

    testWidgets('has accessibility semantics for next button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: TestNavigationButtons(onNext: () {})),
        ),
      );

      // Find the semantics wrapper
      final semantics = tester.getSemantics(
        find
            .ancestor(
              of: find.text('Next Question'),
              matching: find.byType(Semantics),
            )
            .first,
      );
      expect(semantics.label.toLowerCase(), contains('next'));
    });

    testWidgets('has accessibility semantics for complete button', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TestNavigationButtons(onNext: () {}, isLastQuestion: true),
          ),
        ),
      );

      final semantics = tester.getSemantics(
        find
            .ancestor(
              of: find.text('Complete Test'),
              matching: find.byType(Semantics),
            )
            .first,
      );
      expect(semantics.label, contains('Complete'));
    });

    group('responsive layout', () {
      testWidgets('shows column layout on narrow screens', (tester) async {
        tester.view.physicalSize = const Size(320, 480);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: TestNavigationButtons(
                  onNext: () {},
                  onPrevious: () {},
                  showPrevious: true,
                ),
              ),
            ),
          ),
        );

        // Both buttons should be visible
        expect(find.text('Next Question'), findsOneWidget);
        expect(find.text('Previous'), findsOneWidget);
      });

      testWidgets('renders on wide screens', (tester) async {
        tester.view.physicalSize = const Size(800, 600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: TestNavigationButtons(
                  onNext: () {},
                  onPrevious: () {},
                  showPrevious: true,
                ),
              ),
            ),
          ),
        );

        // Both buttons should be visible
        expect(find.text('Next Question'), findsOneWidget);
        expect(find.text('Previous'), findsOneWidget);
      });
    });

    group('button states', () {
      testWidgets('next button is disabled during loading', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TestNavigationButtons(onNext: () {}, isLoading: true),
            ),
          ),
        );

        // Should show loading indicator instead of button text
        expect(find.text('Next Question'), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });
  });
}
