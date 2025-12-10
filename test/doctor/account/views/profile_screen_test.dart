import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DoctorProfileScreen States', () {
    testWidgets('LoadingView renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: LoadingView(message: 'Loading profile...')),
        ),
      );

      expect(find.byType(LoadingView), findsOneWidget);
      expect(find.text('Loading profile...'), findsOneWidget);
    });

    testWidgets('ErrorView renders with retry button', (tester) async {
      bool retryPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorView(
              message: 'Failed to load profile',
              onRetry: () => retryPressed = true,
            ),
          ),
        ),
      );

      expect(find.byType(ErrorView), findsOneWidget);
      expect(find.text('Failed to load profile'), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);

      await tester.tap(find.text('Try Again'));
      await tester.pump();

      expect(retryPressed, isTrue);
    });

    testWidgets('EmptyView renders with action button', (tester) async {
      bool actionPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyView(
              title: 'No Profile Found',
              message: 'We could not find your profile.',
              onAction: () => actionPressed = true,
              actionText: 'Retry',
            ),
          ),
        ),
      );

      expect(find.byType(EmptyView), findsOneWidget);
      expect(find.text('No Profile Found'), findsOneWidget);
      expect(find.text('We could not find your profile.'), findsOneWidget);

      await tester.tap(find.text('Retry'));
      await tester.pump();

      expect(actionPressed, isTrue);
    });
  });

  group('DoctorProfileScreen Responsiveness', () {
    testWidgets('handles small screen width (320dp) without overflow', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: LoadingView(message: 'Loading...')),
        ),
      );

      expect(tester.takeException(), isNull);

      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets('handles tablet width (768dp) without overflow', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(768, 1024);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: LoadingView(message: 'Loading...')),
        ),
      );

      expect(tester.takeException(), isNull);

      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets('handles text scale factor 1.5 without clipping', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(1.5)),
          child: MaterialApp(
            home: Scaffold(body: LoadingView(message: 'Loading...')),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });
  });

  group('Core UI Components', () {
    testWidgets('AppButton renders correctly', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Edit Profile',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      expect(find.text('Edit Profile'), findsOneWidget);

      await tester.tap(find.text('Edit Profile'));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('AppButton.secondary renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.secondary(
              label: 'Change Password',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Change Password'), findsOneWidget);
    });

    testWidgets('AppCard renders child content', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppCard(child: Text('Card Content'))),
        ),
      );

      expect(find.byType(AppCard), findsOneWidget);
      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('SectionHeader renders title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SectionHeader(title: 'Professional Details')),
        ),
      );

      expect(find.byType(SectionHeader), findsOneWidget);
      expect(find.text('Professional Details'), findsOneWidget);
    });
  });
}
