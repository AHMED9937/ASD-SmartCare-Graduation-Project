import 'package:asdsmartcare/shared/auth/verification/views/widgets/otp_verification_body.dart';
import 'package:asdsmartcare/core/ui/text_fields/app_otp_field.dart';
import 'package:asdsmartcare/core/ui/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders title and otp field correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtpVerificationBody(
            isLoading: false,
            onSubmit: (_) {},
            onVerify: () {},
          ),
        ),
      ),
    );

    expect(find.text('OTP Verification'), findsOneWidget);
    expect(find.byType(AppOtpField), findsOneWidget);
    expect(find.text('Verify'), findsOneWidget);
  });

  testWidgets('verify button triggers callback', (WidgetTester tester) async {
    bool verifyPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtpVerificationBody(
            isLoading: false,
            onSubmit: (_) {},
            onVerify: () {
              verifyPressed = true;
            },
          ),
        ),
      ),
    );

    // Tap Verify
    await tester.tap(find.byType(AppButton)); // Only one button (Verify)
    await tester.pump();

    expect(verifyPressed, isTrue);
  });

  testWidgets('shows loading indicator when loading', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtpVerificationBody(
            isLoading: true,
            onSubmit: (_) {},
            onVerify: () {},
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Verify'), findsNothing);
  });

  testWidgets('shows error message when provided', (WidgetTester tester) async {
    const errorMsg = 'Invalid OTP Code';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtpVerificationBody(
            isLoading: false,
            errorMessage: errorMsg,
            onSubmit: (_) {},
            onVerify: () {},
          ),
        ),
      ),
    );

    expect(find.text(errorMsg), findsOneWidget);
    // You could also test for color but finding the text confirms UI presence
  });
}
