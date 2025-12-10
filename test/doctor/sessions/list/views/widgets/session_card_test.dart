import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asdsmartcare/doctor/sessions/list/views/widgets/session_card.dart';

void main() {
  group('SessionCard', () {
    testWidgets('renders correctly with data', (tester) async {
      bool tapped = false;
      final date = DateTime(2023, 10, 27, 14, 30);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SessionCard(
              childName: 'John Doe',
              age: '5',
              gender: 'Male',
              date: date,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('5 years • Male'), findsOneWidget);
      expect(find.text('27 Oct 2023'), findsOneWidget);
      expect(find.text('02:30 PM'), findsOneWidget);

      await tester.tap(find.byType(SessionCard));
      expect(tapped, isTrue);
    });

    testWidgets('renders fallback when childName is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SessionCard(onTap: () {})),
        ),
      );

      expect(find.text('No child'), findsOneWidget);
    });

    testWidgets('has correct semantics', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SessionCard(childName: 'John Doe', onTap: () {}),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(SessionCard));
      expect(semantics.label, 'Session for John Doe');
      expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue);
    });
  });
}
