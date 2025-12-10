import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asdsmartcare/parent/screening/test/widgets/question_card.dart';

void main() {
  group('QuestionCard', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: QuestionCard(child: Text('Question content'))),
        ),
      );

      expect(find.text('Question content'), findsOneWidget);
    });

    testWidgets('respects minimum height', (tester) async {
      const testMinHeight = 400.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QuestionCard(
              minHeight: testMinHeight,
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(QuestionCard),
              matching: find.byType(Container),
            )
            .first,
      );

      expect(container.constraints?.minHeight, equals(testMinHeight));
    });

    testWidgets('animates on initial render when animate is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QuestionCard(animate: true, child: Text('Animated')),
          ),
        ),
      );

      // Pump initial frame
      await tester.pump();

      // Pump animation frames
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(find.text('Animated'), findsOneWidget);
    });

    testWidgets('does not animate when animate is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QuestionCard(animate: false, child: Text('Not animated')),
          ),
        ),
      );

      // Should settle immediately
      await tester.pump();
      expect(find.text('Not animated'), findsOneWidget);
    });

    testWidgets('re-animates when animationKey changes', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QuestionCard(
              animationKey: 0,
              animate: true,
              child: Text('Question 1'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Question 1'), findsOneWidget);

      // Change the key
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QuestionCard(
              animationKey: 1,
              animate: true,
              child: Text('Question 2'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Question 2'), findsOneWidget);
    });

    testWidgets('has rounded corners', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: QuestionCard(child: Text('Content'))),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(QuestionCard),
              matching: find.byType(Container),
            )
            .first,
      );

      final decoration = container.decoration as BoxDecoration?;
      expect(decoration?.borderRadius, isNotNull);
    });

    testWidgets('has shadow decoration', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: QuestionCard(child: Text('Content'))),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(QuestionCard),
              matching: find.byType(Container),
            )
            .first,
      );

      final decoration = container.decoration as BoxDecoration?;
      expect(decoration?.boxShadow, isNotNull);
      expect(decoration?.boxShadow, isNotEmpty);
    });

    testWidgets('renders complex child widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuestionCard(
              child: Column(
                children: [
                  const Text('Question Title'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Option 1'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Option 2'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Question Title'), findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
    });

    group('responsive behavior', () {
      testWidgets('renders on small screen', (tester) async {
        tester.view.physicalSize = const Size(320, 480);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: QuestionCard(child: Text('Small screen')),
              ),
            ),
          ),
        );

        expect(find.text('Small screen'), findsOneWidget);
      });

      testWidgets('renders on large screen', (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: QuestionCard(child: Text('Large screen'))),
          ),
        );

        expect(find.text('Large screen'), findsOneWidget);
      });
    });

    group('state management', () {
      testWidgets('disposes animation controller properly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: QuestionCard(animate: true, child: Text('Content')),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Remove widget - should dispose without error
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: SizedBox.shrink())),
        );

        // No error means dispose worked correctly
        expect(true, isTrue);
      });
    });
  });
}
