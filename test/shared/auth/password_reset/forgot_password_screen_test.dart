import 'package:asdsmartcare/shared/auth/password_reset/widgets/forgot_password_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders title and fields correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ForgotPasswordBody(
            formKey: GlobalKey<FormState>(),
            emailController: TextEditingController(),
            onSendCode: () {},
            isLoading: false,
          ),
        ),
      ),
    );

    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Send Code'), findsOneWidget);
  });

  testWidgets('shows validation error on empty submit', (
    WidgetTester tester,
  ) async {
    final formKey = GlobalKey<FormState>();
    bool sendPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ForgotPasswordBody(
            formKey: formKey,
            emailController: TextEditingController(),
            onSendCode: () {
              if (formKey.currentState!.validate()) {
                sendPressed = true;
              }
            },
            isLoading: false,
          ),
        ),
      ),
    );

    // Tap Send Code
    await tester.tap(find.text('Send Code'));
    await tester.pump();

    // Check for validation message (Should prevent sendPressed)
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(sendPressed, isFalse);
  });
}
