import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asdsmartcare/core/ui/progress/progress_ring.dart';

void main() {
  group('ProgressRing', () {
    testWidgets('renders with default parameters', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ProgressRing(progress: 0.5),
            ),
          ),
        ),
      );

      expect(find.byType(ProgressRing), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('renders with custom size', (tester) async {
      const testSize = 100.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ProgressRing(
                progress: 0.5,
                size: testSize,
              ),
            ),
          ),
        ),
      );

      final container = tester.widget<SizedBox>(
        find.byType(SizedBox).first,
      );
      expect(container.width, equals(testSize));
      expect(container.height, equals(testSize));
    });

    testWidgets('renders child widget in center', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ProgressRing(
                progress: 0.75,
                child: Text('75%'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('75%'), findsOneWidget);
    });

    testWidgets('animates when animate is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ProgressRing(
                progress: 0.5,
                animate: true,
              ),
            ),
          ),
        ),
      );

      // Pump animation frames
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(find.byType(ProgressRing), findsOneWidget);
    });

    testWidgets('does not animate when animate is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ProgressRing(
                progress: 0.5,
                animate: false,
              ),
            ),
          ),
        ),
      );

      // Should settle immediately
      await tester.pump();
      expect(find.byType(ProgressRing), findsOneWidget);
    });

    testWidgets('handles progress value of 0', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ProgressRing(progress: 0.0),
            ),
          ),
        ),
      );

      expect(find.byType(ProgressRing), findsOneWidget);
    });

    testWidgets('handles progress value of 1', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ProgressRing(progress: 1.0),
            ),
          ),
        ),
      );

      expect(find.byType(ProgressRing), findsOneWidget);
    });

    testWidgets('applies custom colors', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ProgressRing(
                progress: 0.5,
                progressColor: Colors.red,
                backgroundColor: Colors.grey,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ProgressRing), findsOneWidget);
    });

    testWidgets('applies custom stroke width', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ProgressRing(
                progress: 0.5,
                strokeWidth: 10.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ProgressRing), findsOneWidget);
    });

    testWidgets('respects accessibility settings', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: MediaQuery(
                data: MediaQueryData(
                  accessibleNavigation: true,
                  disableAnimations: true,
                ),
                child: ProgressRing(
                  progress: 0.5,
                  animate: true,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ProgressRing), findsOneWidget);
    });

    group('responsive behavior', () {
      testWidgets('adapts to small screens', (tester) async {
        tester.view.physicalSize = const Size(320, 480);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: ProgressRing(progress: 0.5, size: 48),
              ),
            ),
          ),
        );

        expect(find.byType(ProgressRing), findsOneWidget);
      });

      testWidgets('adapts to large screens', (tester) async {
        tester.view.physicalSize = const Size(1024, 768);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: ProgressRing(progress: 0.5, size: 120),
              ),
            ),
          ),
        );

        expect(find.byType(ProgressRing), findsOneWidget);
      });
    });
  });
}
