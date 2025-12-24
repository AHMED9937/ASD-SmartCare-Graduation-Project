import 'package:asdsmartcare/doctor/sessions/manage/views/widgets/feedback_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FeedbackCard renders comment and timestamp', (tester) async {
    bool editCalled = false;
    bool deleteCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FeedbackCard(
            comment: 'Test Comment',
            timestamp: 'Dec 23, 2025',
            onEdit: () => editCalled = true,
            onDelete: () => deleteCalled = true,
          ),
        ),
      ),
    );

    expect(find.text('Test Comment'), findsOneWidget);
    expect(find.text('Dec 23, 2025'), findsOneWidget);

    // Open menu
    await tester.tap(find.byIcon(Icons.more_vert_rounded));
    await tester.pumpAndSettle();

    // Tap Edit
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    expect(editCalled, isTrue);

    // Open menu again for delete
    await tester.tap(find.byIcon(Icons.more_vert_rounded));
    await tester.pumpAndSettle();

    // Tap Delete
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(deleteCalled, isTrue);
  });
}
