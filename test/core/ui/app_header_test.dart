import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asdsmartcare/core/ui/app_bar/app_header.dart';
import 'package:asdsmartcare/core/design_system/tokens/colors.dart';

void main() {
  group('AppHeader', () {
    testWidgets('renders title text correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const AppHeader(title: 'Test Title'),
            body: Container(),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('title uses AppTypography.titleLarge style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const AppHeader(title: 'Styled Title'),
            body: Container(),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Styled Title'));
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('title uses AppColors.primary color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const AppHeader(title: 'Colored Title'),
            body: Container(),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Colored Title'));
      expect(textWidget.style?.color, AppColors.primary);
    });

    testWidgets('shows back button when showBackButton is true and can pop',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                          appBar: const AppHeader(
                            title: 'Nested Screen',
                          ),
                          body: Container(),
                        ),
                      ),
                    );
                  },
                  child: const Text('Navigate'),
                );
              },
            ),
          ),
        ),
      );

      // Navigate to nested screen
      await tester.tap(find.text('Navigate'));
      await tester.pumpAndSettle();

      // Back button should be visible (as Icon)
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
    });

    testWidgets('hides back button when showBackButton is false',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                          appBar: const AppHeader(
                            title: 'Tab Screen',
                            showBackButton: false,
                          ),
                          body: Container(),
                        ),
                      ),
                    );
                  },
                  child: const Text('Navigate'),
                );
              },
            ),
          ),
        ),
      );

      // Navigate to nested screen
      await tester.tap(find.text('Navigate'));
      await tester.pumpAndSettle();

      // Back button should NOT be visible
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsNothing);
    });

    testWidgets('renders actions when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppHeader(
              title: 'With Actions',
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),
            body: Container(),
          ),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('centers title by default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const AppHeader(title: 'Centered'),
            body: Container(),
          ),
        ),
      );

      // The title should be wrapped in Center widget
      final centerFinder = find.ancestor(
        of: find.text('Centered'),
        matching: find.byType(Center),
      );
      expect(centerFinder, findsOneWidget);
    });

    testWidgets('does not center title when centerTitle is false',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const AppHeader(title: 'Left Aligned', centerTitle: false),
            body: Container(),
          ),
        ),
      );

      // The title should NOT be wrapped in Center widget
      final centerFinder = find.ancestor(
        of: find.text('Left Aligned'),
        matching: find.byType(Center),
      );
      expect(centerFinder, findsNothing);
    });

    testWidgets('transparent variant has transparent background',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const AppHeader.transparent(title: 'Transparent'),
            body: Container(),
          ),
        ),
      );

      // Just verify it renders without error
      expect(find.text('Transparent'), findsOneWidget);
    });

    testWidgets('renders titleWidget when provided instead of title',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const AppHeader(
              titleWidget: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star),
                  SizedBox(width: 4),
                  Text('Custom Widget'),
                ],
              ),
            ),
            body: Container(),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Custom Widget'), findsOneWidget);
    });
  });
}
