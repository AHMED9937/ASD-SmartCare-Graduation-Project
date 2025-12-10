import 'package:asdsmartcare/shared/auth/password_reset/views/widgets/reset_password_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Create a mock Cubit if needed, or rely on simple widget testing for UI presence
// Since this test focuses on UI, we will test ResetPasswordBody directly mostly,
// or test the screen by injecting a Cubit.
// For simplicity and speed, we will verify the BODY first.

void main() {
  group('ResetPasswordBody Widget Tests', () {
    late TextEditingController newPassController;
    late TextEditingController confirmPassController;

    setUp(() {
      newPassController = TextEditingController();
      confirmPassController = TextEditingController();
    });

    testWidgets('renders title, inputs, and button correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResetPasswordBody(
              newPasswordController: newPassController,
              confirmPasswordController: confirmPassController,
              onReset: () {},
              isLoading: false,
            ),
          ),
        ),
      );

      // Verify Title
      expect(find.text('Create new password'), findsOneWidget);
      expect(find.textContaining('must be unique'), findsOneWidget);

      // Verify Inputs
      expect(find.text('New Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);

      // Verify Button
      expect(find.text('Reset Password'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('shows loading indicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResetPasswordBody(
              newPasswordController: newPassController,
              confirmPasswordController: confirmPassController,
              onReset: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Reset Password'), findsNothing);
    });
  });
}
