import 'package:asdsmartcare/doctor/sessions/manage/views/widgets/feedback_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FeedbackDialog validates empty input', (tester) async {
    String? result;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                result = await showDialog<String>(
                  context: context,
                  builder: (_) => const FeedbackDialog(
                    title: 'Test Title',
                    actionLabel: 'Add',
                  ),
                );
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    expect(find.text('Test Title'), findsOneWidget);

    // Try to submit empty
    await tester.tap(find.text('Add'));
    await tester.pump();

    expect(find.text('Feedback cannot be empty'), findsOneWidget);

    // Enter text and submit
    await tester.enterText(find.byType(TextField), 'Valid Feedback');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(result, 'Valid Feedback');
  });

  testWidgets('FeedbackDialog shows initial text', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FeedbackDialog(
            title: 'Edit',
            initialText: 'Initial Text',
            actionLabel: 'Save',
          ),
        ),
      ),
    );

    expect(find.text('Initial Text'), findsOneWidget);
  });
}
