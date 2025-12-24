import 'package:asdsmartcare/shared/auth/login/views/select_role_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Create a minimal mock for CacheHelper if needed, but since save data is static and void,
  // we might get away with it if shared_preferences is mocked.
  // Actually, CacheHelper usually requires initialization.
  // For UI tests, we care about the TAP and Navigation.
  // We can just verify the Widgets exist first.

  group('Selectusertypescreen Widget Tests', () {
    testWidgets('renders title and cards correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Selectusertypescreen(),
      ));

      // Trigger standard animations
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Verify Header
      expect(find.textContaining('WELCOME'), findsOneWidget); // Uppercase check
      expect(find.textContaining('Who are you'), findsOneWidget);

      // Verify Icons
      expect(find.byIcon(Icons.medical_services_rounded), findsOneWidget);
      expect(find.byIcon(Icons.family_restroom_rounded), findsOneWidget);

      // Verify Cards
      expect(find.text('Doctor'), findsOneWidget);
      expect(find.text('Parent'), findsOneWidget);

      // Verify Subtitles (ensure cards are rendered fully)
      expect(find.text('Manage appointments & patients'), findsOneWidget);
      expect(find.text('Find care & track progress'), findsOneWidget);
    });
  });
}
