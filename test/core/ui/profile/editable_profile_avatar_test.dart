import 'package:asdsmartcare/core/ui/profile/editable_profile_avatar.dart';
import 'package:asdsmartcare/core/ui/profile/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditableProfileAvatar', () {
    testWidgets('renders base ProfileAvatar when no pickedImage is provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: EditableProfileAvatar(onTap: () {})),
        ),
      );

      expect(find.byType(ProfileAvatar), findsOneWidget);
      expect(find.byIcon(Icons.camera_alt_rounded), findsOneWidget);
    });

    testWidgets('triggers onTap when tapped', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditableProfileAvatar(onTap: () => tapped = true),
          ),
        ),
      );

      await tester.tap(find.byType(EditableProfileAvatar));
      expect(tapped, isTrue);
    });
  });
}
