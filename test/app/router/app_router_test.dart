/// Unit tests for the centralized Navigator 1.0 route table.
///
/// Tests verify:
/// - All defined routes resolve to correct screens
/// - Unknown routes return fallback 404 screen
/// - Route arguments are properly validated
/// - Helper navigation methods work correctly
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:asdsmartcare/doctor/navigation/doctor_navigation_screen.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/models/booking_response.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/views/booking_screen.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/views/confirm_booking_screen.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/views/payment_screen.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/models/doctor_model.dart';
import 'package:asdsmartcare/shared/auth/login/views/login_screen.dart';
import 'package:asdsmartcare/shared/auth/login/views/select_role_screen.dart';
import 'package:asdsmartcare/shared/auth/onboarding/views/onboarding_screen.dart';
import 'package:asdsmartcare/shared/auth/password_reset/views/forgot_password_screen.dart';
import 'package:asdsmartcare/shared/auth/password_reset/views/new_password_screen.dart';
import 'package:asdsmartcare/shared/auth/signup/views/doctor_signup_screen.dart';
import 'package:asdsmartcare/shared/auth/signup/views/parent_signup_screen.dart';
import 'package:asdsmartcare/shared/auth/verification/views/otp_screen.dart';

void main() {
  group('AppRoutes', () {
    test('initial route is onboarding', () {
      expect(AppRoutes.initial, equals(AppRoutes.onboarding));
    });

    test('all auth routes are defined', () {
      expect(AppRoutes.onboarding, equals('/onboarding'));
      expect(AppRoutes.login, equals('/login'));
      expect(AppRoutes.selectRole, equals('/select-role'));
      expect(AppRoutes.register, equals('/register'));
      expect(AppRoutes.registerParent, equals('/register/parent'));
      expect(AppRoutes.registerDoctor, equals('/register/doctor'));
      expect(AppRoutes.forgotPassword, equals('/forgot-password'));
      expect(AppRoutes.newPassword, equals('/new-password'));
      expect(AppRoutes.verifyEmail, equals('/verify-email'));
      expect(AppRoutes.otpVerification, equals('/otp-verification'));
    });

    test('all parent routes are defined', () {
      expect(AppRoutes.parentHome, equals('/parent/home'));
      expect(AppRoutes.parentDashboard, equals('/parent/dashboard'));
      expect(AppRoutes.findDoctors, equals('/parent/find-doctors'));
      expect(AppRoutes.booking, equals('/parent/booking'));
      expect(AppRoutes.bookingSearch, equals('/parent/booking/search'));
      expect(AppRoutes.bookingPayment, equals('/parent/booking/payment'));
      expect(AppRoutes.bookingConfirm, equals('/parent/booking/confirm'));
      expect(AppRoutes.myChildren, equals('/parent/my-children'));
      expect(AppRoutes.childProgress, equals('/parent/child-progress'));
      expect(AppRoutes.chatbot, equals('/parent/chatbot'));
      expect(AppRoutes.education, equals('/parent/education'));
    });

    test('all doctor routes are defined', () {
      expect(AppRoutes.doctorHome, equals('/doctor/home'));
      expect(AppRoutes.doctorDashboard, equals('/doctor/dashboard'));
      expect(AppRoutes.myPatients, equals('/doctor/my-patients'));
      expect(AppRoutes.appointments, equals('/doctor/appointments'));
      expect(AppRoutes.sessions, equals('/doctor/sessions'));
      expect(AppRoutes.clinic, equals('/doctor/clinic'));
    });

    test('shared routes are defined', () {
      expect(AppRoutes.profile, equals('/profile'));
      expect(AppRoutes.settings, equals('/settings'));
      expect(AppRoutes.notFound, equals('/404'));
    });
  });

  group('AppRouter.onGenerateRoute', () {
    group('Auth Routes', () {
      test('onboarding route returns OnboardingNavigationScreens', () {
        const settings = RouteSettings(name: AppRoutes.onboarding);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<OnboardingNavigationScreens>());
      });

      test('login route returns LoginScreen', () {
        const settings = RouteSettings(name: AppRoutes.login);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<LoginScreen>());
      });

      test('selectRole route returns Selectusertypescreen', () {
        const settings = RouteSettings(name: AppRoutes.selectRole);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<Selectusertypescreen>());
      });

      test('registerParent route returns ParentSignUpScreen', () {
        const settings = RouteSettings(name: AppRoutes.registerParent);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<ParentSignUpScreen>());
      });

      test('registerDoctor route returns Doctorsignupscreen', () {
        const settings = RouteSettings(name: AppRoutes.registerDoctor);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<Doctorsignupscreen>());
      });

      test('forgotPassword route returns Forgetpasswordscreen', () {
        const settings = RouteSettings(name: AppRoutes.forgotPassword);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<Forgetpasswordscreen>());
      });

      test('newPassword route returns CreatenewpasswordScreen', () {
        const settings = RouteSettings(name: AppRoutes.newPassword);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<CreatenewpasswordScreen>());
      });

      test('otpVerification route returns Otpverificationscreen', () {
        const settings = RouteSettings(name: AppRoutes.otpVerification);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<Otpverificationscreen>());
      });
    });

    group('Parent Routes', () {
      test('parentHome route returns ParentBottomNavgationScreen', () {
        const settings = RouteSettings(name: AppRoutes.parentHome);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<MultiBlocProvider>());
      });

      test('parentDashboard route returns ParentBottomNavgationScreen', () {
        const settings = RouteSettings(name: AppRoutes.parentDashboard);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<MultiBlocProvider>());
      });

      test('booking route without arguments returns NotFoundScreen', () {
        const settings = RouteSettings(name: AppRoutes.booking);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        // Should return fallback when no Doctor argument provided
        expect(widget.runtimeType.toString(), contains('NotFoundScreen'));
      });

      test('booking route with Doctor argument returns Reservationscreen', () {
        final doctor = Doctor(id: 'doc-123');
        final settings = RouteSettings(
          name: AppRoutes.booking,
          arguments: doctor,
        );
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<Reservationscreen>());
      });

      test('bookingPayment route without arguments returns NotFoundScreen', () {
        const settings = RouteSettings(name: AppRoutes.bookingPayment);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget.runtimeType.toString(), contains('NotFoundScreen'));
      });

      test('bookingPayment route with arguments returns Paymenttype', () {
        final doctor = Doctor(id: 'doc-123');
        final session = BookSession()..message = 'test';
        final args = BookingPaymentArgs(doctor: doctor, session: session);
        final settings = RouteSettings(
          name: AppRoutes.bookingPayment,
          arguments: args,
        );
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<PaymentType>());
      });

      test('bookingConfirm route without arguments returns NotFoundScreen', () {
        const settings = RouteSettings(name: AppRoutes.bookingConfirm);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget.runtimeType.toString(), contains('NotFoundScreen'));
      });

      test(
        'bookingConfirm route with arguments returns Confirmreservationscreen',
        () {
          final doctor = Doctor(id: 'doc-123');
          final session = BookSession()..message = 'test';
          final args = BookingConfirmArgs(doctor: doctor, session: session);
          final settings = RouteSettings(
            name: AppRoutes.bookingConfirm,
            arguments: args,
          );
          final route = AppRouter.onGenerateRoute(settings);

          expect(route, isA<MaterialPageRoute>());
          final pageRoute = route as MaterialPageRoute;
          final widget = pageRoute.builder(MockBuildContext());
          expect(widget, isA<Confirmreservationscreen>());
        },
      );
    });

    group('Doctor Routes', () {
      test('doctorHome route returns Doctornavgationscreen', () {
        const settings = RouteSettings(name: AppRoutes.doctorHome);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<Doctornavgationscreen>());
      });

      test('doctorDashboard route returns Doctornavgationscreen', () {
        const settings = RouteSettings(name: AppRoutes.doctorDashboard);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget, isA<Doctornavgationscreen>());
      });
    });

    group('Fallback Routes', () {
      test('notFound route returns NotFoundScreen', () {
        const settings = RouteSettings(name: AppRoutes.notFound);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget.runtimeType.toString(), contains('NotFoundScreen'));
      });

      test('unknown route returns NotFoundScreen', () {
        const settings = RouteSettings(name: '/unknown/route/path');
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget.runtimeType.toString(), contains('NotFoundScreen'));
      });

      test('null route name returns NotFoundScreen', () {
        const settings = RouteSettings(name: null);
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget.runtimeType.toString(), contains('NotFoundScreen'));
      });

      test('empty route name returns NotFoundScreen', () {
        const settings = RouteSettings(name: '');
        final route = AppRouter.onGenerateRoute(settings);

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        final widget = pageRoute.builder(MockBuildContext());
        expect(widget.runtimeType.toString(), contains('NotFoundScreen'));
      });
    });
  });

  group('BookingPaymentArgs', () {
    test('creates instance with required properties', () {
      final doctor = Doctor(id: 'doc-123');
      final session = BookSession()..message = 'test session';

      final args = BookingPaymentArgs(doctor: doctor, session: session);

      expect(args.doctor.id, equals('doc-123'));
      expect(args.session.message, equals('test session'));
    });
  });

  group('BookingConfirmArgs', () {
    test('creates instance with required properties', () {
      final doctor = Doctor(id: 'doc-456');
      final session = BookSession()..message = 'confirm session';

      final args = BookingConfirmArgs(doctor: doctor, session: session);

      expect(args.doctor.id, equals('doc-456'));
      expect(args.session.message, equals('confirm session'));
    });
  });
}

/// Mock BuildContext for testing route builders.
class MockBuildContext extends Fake implements BuildContext {}
