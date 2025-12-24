import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/auth/login/controllers/login_cubit.dart';
import 'package:asdsmartcare/shared/auth/login/controllers/login_state.dart';
import 'package:asdsmartcare/shared/auth/login/views/login_screen.dart';
import 'package:asdsmartcare/shared/auth/login/views/widgets/login_header.dart';
import 'package:asdsmartcare/shared/auth/login/views/widgets/login_form.dart';
import 'package:asdsmartcare/shared/auth/login/views/widgets/login_actions.dart';

class MockUserLoginCubit extends Mock implements UserLoginCubit {
  @override
  Stream<UserLoginState> get stream => const Stream.empty();
}

void main() {
  late MockUserLoginCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(LoginInitial());
  });

  setUp(() async {
    mockCubit = MockUserLoginCubit();
    when(() => mockCubit.state).thenReturn(LoginInitial());

    // Mock SharedPreferences for CacheHelper
    SharedPreferences.setMockInitialValues({});
    await CacheHelper.init();
  });

  Widget createWidget() {
    return MaterialApp(
      home: LoginScreen(cubit: mockCubit),
    );
  }

  group('LoginScreen Redesign Tests', () {
    testWidgets('renders all main sections (Header, Form, Actions)',
        (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(LoginHeader), findsOneWidget);
      expect(find.byType(LoginForm), findsOneWidget);
      expect(find.byType(LoginActions), findsOneWidget);
      expect(find.text('Welcome Back!'), findsOneWidget);
      expect(find.text('Log In'), findsWidgets);
    });

    testWidgets('shows loading indicator when state is LoginLoading',
        (tester) async {
      when(() => mockCubit.state).thenReturn(LoginLoading());
      await tester.pumpWidget(createWidget());

      // LoadingView is shown instead of the login button in LoginActions
      expect(find.byType(LoadingView), findsOneWidget);
      expect(find.byType(AppButton), findsNothing);
    });

    testWidgets('validates fields on login attempt', (tester) async {
      await tester.pumpWidget(createWidget());

      // Find the "Log In" button in LoginActions
      final loginButton = find.text('Log In').first;
      await tester.tap(loginButton);
      await tester.pump();

      // Check validation errors (handled by AppTextFields inside LoginForm)
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('toggles Remember Me checkbox', (tester) async {
      await tester.pumpWidget(createWidget());

      // Initial state should be false (from the mock setup or stateful widget default)
      expect(CacheHelper.getData(key: 'rememberMe'), isNull);

      // Tap the label
      await tester.tap(find.text('Remember Me'));
      await tester.pump();

      // Verify CacheHelper has the new value
      expect(CacheHelper.getData(key: 'rememberMe'), isTrue);
    });
  });
}
