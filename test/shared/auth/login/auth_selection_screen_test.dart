import 'package:asdsmartcare/shared/auth/login/views/auth_selection_screen.dart';
import 'package:asdsmartcare/shared/auth/login/widgets/auth_selection_body.dart';
import 'package:asdsmartcare/core/ui/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthSelectionScreen Tests', () {
    testWidgets('renders all widgets correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: AuthSelectionScreen(),
      ));

      // Verify Body
      expect(find.byType(AuthSelectionBody), findsOneWidget);

      // Verify Text
      expect(find.text("Let's get started!"), findsOneWidget);
      expect(
          find.text(
              'Choose login if you already have an account\nor sign up if this is your first time.'),
          findsOneWidget);

      // Verify Buttons
      expect(find.text('Log in'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.byType(AppButton), findsNWidgets(2));
    });

    testWidgets('login button is tappable', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: AuthSelectionScreen(),
      ));

      await tester.tap(find.text('Log in'));
      await tester.pump();
      // Verifies no crash on tap
    });

    testWidgets('signup button is tappable', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: AuthSelectionScreen(),
      ));

      await tester.tap(find.text('Sign Up'));
      await tester.pump();
      // Verifies no crash on tap
    });
  });
}
