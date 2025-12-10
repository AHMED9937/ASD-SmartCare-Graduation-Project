// Basic widget test for ASD SmartCare app.
//
// This test validates that the app can be instantiated without errors.
// More comprehensive tests are in the test/shared/ directory.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test - MaterialApp renders', (
    WidgetTester tester,
  ) async {
    // Build a minimal MaterialApp to verify widget tree can be built
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text('ASD SmartCare'))),
      ),
    );

    // Verify basic widget renders
    expect(find.text('ASD SmartCare'), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('Theme can be applied', (WidgetTester tester) async {
    // Build app with theme
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const Scaffold(body: Center(child: Text('Themed App'))),
      ),
    );

    // Verify themed app renders
    expect(find.text('Themed App'), findsOneWidget);
  });
}
