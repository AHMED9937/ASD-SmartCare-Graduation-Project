import 'package:asdsmartcare/core/ui/buttons/app_button.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/parent_signup_cubit.dart';
import 'package:asdsmartcare/shared/auth/signup/views/parent_signup_screen.dart';
import 'package:asdsmartcare/shared/auth/signup/views/widgets/parent_signup_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Create a safe subclass that doesn't trigger side effects if any exist
class TestParentSignUpCubit extends ParentSignUpCubit {
  // Override any dangerous methods if necessary
}

void main() {
  testWidgets('ParentSignUpScreen renders correctly', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(400, 900);
    tester.view.devicePixelRatio = 1.0;

    // Use the safe Cubit
    final cubit = TestParentSignUpCubit();

    await tester.pumpWidget(
      MaterialApp(home: ParentSignUpScreen(cubit: cubit)),
    );

    // Let animations complete naturally
    await tester.pumpAndSettle();

    // Verify Body exists
    expect(find.byType(ParentSignupBody), findsOneWidget);

    // Verify Header
    expect(find.textContaining('Create Account'), findsOneWidget);

    // Verify Fields presence (Hints)
    expect(find.textContaining('Full Name'), findsOneWidget);

    // Test Validation - Tap Button to trigger errors
    final buttonFinder = find.widgetWithText(AppButton, 'Create Account');
    await tester.ensureVisible(buttonFinder);
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    // Expect Error Messages
    expect(find.text('Full name is required'), findsOneWidget);
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Phone number is required'), findsOneWidget);
    expect(find.text('Required'), findsOneWidget); // Age
    expect(find.text('Address is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);

    addTearDown(tester.view.resetPhysicalSize);
  });
}
