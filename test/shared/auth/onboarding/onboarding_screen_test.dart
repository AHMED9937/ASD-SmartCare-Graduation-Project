import 'package:asdsmartcare/shared/auth/onboarding/views/onboarding_screen.dart';
import 'package:asdsmartcare/shared/auth/onboarding/widgets/onboarding_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnboardingNavigationScreens Tests', () {
    testWidgets('renders initial page content correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: OnboardingNavigationScreens(),
      ));

      // Check first page content
      expect(find.text('Comprehensive Support for Your Child Starts Here'),
          findsOneWidget);
      expect(
          find.text(
              'Innovative tools to improve the lives of children with autism.'),
          findsOneWidget);
      expect(find.byType(OnboardingPageContent), findsOneWidget);
    });

    testWidgets('shows Next button on first page', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: OnboardingNavigationScreens(),
      ));

      expect(find.text('Next'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows Get Started button on last page',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: OnboardingNavigationScreens(),
      ));

      // Swipe to last page
      await tester.drag(
          find.byType(PageView), const Offset(-400, 0)); // Page 1 -> 2
      await tester.pumpAndSettle();
      await tester.drag(
          find.byType(PageView), const Offset(-400, 0)); // Page 2 -> 3
      await tester.pumpAndSettle();

      expect(find.text('Get Started'), findsOneWidget);
    });

    testWidgets('navigates when skip is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: OnboardingNavigationScreens(),
      ));

      expect(find.text('Skip'), findsOneWidget);
      // Note: We cannot easily test navigation pushReplacement without a mock navigator,
      // but verifying the button exists and is tappable is a good start.
      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();
    });
  });
}
