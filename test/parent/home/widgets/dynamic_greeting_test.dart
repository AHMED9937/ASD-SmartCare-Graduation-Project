import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/parent/home/widgets/dynamic_greeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('DynamicGreeting Widget Tests', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({'userName': 'Ahmed'});
      await CacheHelper.init();
    });

    testWidgets('renders greeting and user name', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: DynamicGreeting())),
      );

      expect(find.textContaining('Hello, Ahmed'), findsOneWidget);
      // Greeting depends on time, so we just check if one of the greetings is present
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              (widget.data == 'GOOD MORNING' ||
                  widget.data == 'GOOD AFTERNOON' ||
                  widget.data == 'GOOD EVENING'),
        ),
        findsOneWidget,
      );
    });
  });
}
