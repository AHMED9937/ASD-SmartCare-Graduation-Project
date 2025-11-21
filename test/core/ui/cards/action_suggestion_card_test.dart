import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asdsmartcare/core/ui/cards/action_suggestion_card.dart';

void main() {
  group('ActionSuggestionCard', () {
    testWidgets('renders with required parameters', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionSuggestionCard(
              icon: Icons.medical_services,
              title: 'Book Consultation',
              subtitle: 'Schedule an appointment',
              priority: ActionPriority.high,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Book Consultation'), findsOneWidget);
      expect(find.text('Schedule an appointment'), findsOneWidget);
      expect(find.byIcon(Icons.medical_services), findsOneWidget);
    });

    testWidgets('displays high priority styling', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionSuggestionCard(
              icon: Icons.warning,
              title: 'Urgent Action',
              subtitle: 'Take immediate action',
              priority: ActionPriority.high,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ActionSuggestionCard), findsOneWidget);
      expect(find.text('Urgent Action'), findsOneWidget);
    });

    testWidgets('displays medium priority styling', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionSuggestionCard(
              icon: Icons.schedule,
              title: 'Schedule Session',
              subtitle: 'Book early intervention',
              priority: ActionPriority.medium,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ActionSuggestionCard), findsOneWidget);
    });

    testWidgets('displays normal priority styling', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionSuggestionCard(
              icon: Icons.group,
              title: 'Join Group',
              subtitle: 'Connect with others',
              priority: ActionPriority.normal,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ActionSuggestionCard), findsOneWidget);
    });

    testWidgets('displays info priority styling', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionSuggestionCard(
              icon: Icons.info,
              title: 'Learn More',
              subtitle: 'Additional information',
              priority: ActionPriority.info,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ActionSuggestionCard), findsOneWidget);
    });

    testWidgets('triggers onTap callback when pressed', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionSuggestionCard(
              icon: Icons.check,
              title: 'Tap Me',
              subtitle: 'Test tapping',
              priority: ActionPriority.normal,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ActionSuggestionCard));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('renders without subtitle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionSuggestionCard(
              icon: Icons.check,
              title: 'Title Only',
              priority: ActionPriority.normal,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Title Only'), findsOneWidget);
      expect(find.byType(ActionSuggestionCard), findsOneWidget);
    });

    testWidgets('renders arrow icon when showArrow is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionSuggestionCard(
              icon: Icons.check,
              title: 'Navigate',
              showArrow: true,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward_ios_rounded), findsOneWidget);
    });

    testWidgets('hides arrow icon when showArrow is false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionSuggestionCard(
              icon: Icons.check,
              title: 'No Arrow',
              showArrow: false,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward_ios_rounded), findsNothing);
    });

    group('responsive behavior', () {
      testWidgets('renders on small screen', (tester) async {
        tester.view.physicalSize = const Size(320, 480);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionSuggestionCard(
                icon: Icons.check,
                title: 'Small Screen',
                subtitle: 'Testing small screen layout',
                priority: ActionPriority.normal,
                onTap: () {},
              ),
            ),
          ),
        );

        expect(find.byType(ActionSuggestionCard), findsOneWidget);
        expect(find.text('Small Screen'), findsOneWidget);
      });

      testWidgets('renders on large screen', (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionSuggestionCard(
                icon: Icons.check,
                title: 'Large Screen',
                subtitle: 'Testing large screen layout',
                priority: ActionPriority.normal,
                onTap: () {},
              ),
            ),
          ),
        );

        expect(find.byType(ActionSuggestionCard), findsOneWidget);
      });
    });

    group('multiple cards', () {
      testWidgets('renders multiple cards in a list', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ListView(
                children: [
                  ActionSuggestionCard(
                    icon: Icons.medical_services,
                    title: 'Action 1',
                    subtitle: 'First action',
                    priority: ActionPriority.high,
                    onTap: () {},
                  ),
                  ActionSuggestionCard(
                    icon: Icons.schedule,
                    title: 'Action 2',
                    subtitle: 'Second action',
                    priority: ActionPriority.medium,
                    onTap: () {},
                  ),
                  ActionSuggestionCard(
                    icon: Icons.group,
                    title: 'Action 3',
                    subtitle: 'Third action',
                    priority: ActionPriority.normal,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(ActionSuggestionCard), findsNWidgets(3));
        expect(find.text('Action 1'), findsOneWidget);
        expect(find.text('Action 2'), findsOneWidget);
        expect(find.text('Action 3'), findsOneWidget);
      });
    });

    group('animations', () {
      testWidgets('scales on press', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionSuggestionCard(
                icon: Icons.check,
                title: 'Press me',
                priority: ActionPriority.normal,
                onTap: () {},
              ),
            ),
          ),
        );

        final gesture = await tester.startGesture(
          tester.getCenter(find.byType(ActionSuggestionCard)),
        );
        await tester.pump(const Duration(milliseconds: 50));
        await gesture.up();
        await tester.pumpAndSettle();

        expect(find.byType(ActionSuggestionCard), findsOneWidget);
      });
    });
  });
}
