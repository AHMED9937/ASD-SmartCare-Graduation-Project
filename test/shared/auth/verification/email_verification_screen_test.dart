import 'package:asdsmartcare/shared/auth/signup/controllers/parent_signup_cubit.dart';
import 'package:asdsmartcare/shared/auth/verification/views/email_verification_screen.dart';
import 'package:asdsmartcare/shared/auth/verification/views/widgets/email_verification_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Safe Test Mock
class TestParentSignUpCubit extends ParentSignUpCubit {}

void main() {
  testWidgets('Emailverfcationscreen renders correctly',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 900);
    tester.view.devicePixelRatio = 1.0;

    final cubit = TestParentSignUpCubit();

    await tester.pumpWidget(
      MaterialApp(
        home: Emailverfcationscreen(
          parentID: '123',
          parentUserName: 'test_user',
          parentEmail: 'test@example.com',
          cubit: cubit,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Body exists
    expect(find.byType(EmailVerificationBody), findsOneWidget);

    // Verify Title
    expect(find.text('Verify Email'), findsOneWidget);

    // Verify Buttons
    expect(find.text('Verify Account'), findsOneWidget); // New Button Label
    expect(find.textContaining('Resend'), findsOneWidget); // RichText
    expect(find.text('Change'), findsOneWidget); // Chip

    addTearDown(tester.view.resetPhysicalSize);
  });
}
