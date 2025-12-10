import 'package:flutter/material.dart';

import 'package:asdsmartcare/doctor/navigation/doctor_navigation_screen.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/models/booking_response.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/views/booking_screen.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/views/confirm_booking_screen.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/views/payment_screen.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/models/doctor_model.dart';
import 'package:asdsmartcare/parent/navigation/parent_navigation_screen.dart';
import 'package:asdsmartcare/shared/auth/login/views/login_screen.dart';
import 'package:asdsmartcare/shared/auth/login/views/select_role_screen.dart';
import 'package:asdsmartcare/shared/auth/onboarding/views/onboarding_screen.dart';
import 'package:asdsmartcare/shared/auth/password_reset/views/forgot_password_screen.dart';
import 'package:asdsmartcare/shared/auth/password_reset/views/new_password_screen.dart';
import 'package:asdsmartcare/shared/auth/signup/views/doctor_signup_screen.dart';
import 'package:asdsmartcare/shared/auth/signup/views/parent_signup_screen.dart';
import 'package:asdsmartcare/shared/auth/verification/views/otp_screen.dart';

// Services
import 'package:asdsmartcare/parent/screening/views/test_selection/test_selection_screen.dart';
import 'package:asdsmartcare/parent/progress/views/progress_screen.dart';
import 'package:asdsmartcare/parent/education/views/articles_screen.dart';
import 'package:asdsmartcare/parent/chatbot/views/chat_screen.dart';
import 'package:asdsmartcare/shared/medicines/views/medicines_screen.dart';
import 'package:asdsmartcare/shared/donations/views/charities_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_cubit.dart';
import 'package:asdsmartcare/parent/education/controllers/articles_cubit.dart';

/// Centralized route name constants.
///
/// Usage:
/// ```dart
/// Navigator.pushNamed(context, AppRoutes.login);
/// ```
abstract final class AppRoutes {
  // ─────────────────────────────────────────────────────────────────────────────
  // Auth Routes
  // ─────────────────────────────────────────────────────────────────────────────
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String selectRole = '/select-role';
  static const String register = '/register';
  static const String registerParent = '/register/parent';
  static const String registerDoctor = '/register/doctor';
  static const String forgotPassword = '/forgot-password';
  static const String newPassword = '/new-password';
  static const String verifyEmail = '/verify-email';
  static const String otpVerification = '/otp-verification';

  // ─────────────────────────────────────────────────────────────────────────────
  // Parent Routes
  // ─────────────────────────────────────────────────────────────────────────────
  static const String parentHome = '/parent/home';
  static const String parentDashboard = '/parent/dashboard';
  static const String findDoctors = '/parent/find-doctors';
  static const String booking = '/parent/booking';
  static const String bookingSearch = '/parent/booking/search';
  static const String bookingPayment = '/parent/booking/payment';
  static const String bookingConfirm = '/parent/booking/confirm';
  static const String myChildren = '/parent/my-children';
  static const String childProgress = '/parent/child-progress';
  static const String chatbot = '/parent/chatbot';
  static const String education = '/parent/education';
  static const String autismTest = '/parent/autism-test';
  static const String medicines = '/parent/medicines';
  static const String charity = '/parent/charity';

  // ─────────────────────────────────────────────────────────────────────────────
  // Doctor Routes
  // ─────────────────────────────────────────────────────────────────────────────
  static const String doctorHome = '/doctor/home';
  static const String doctorDashboard = '/doctor/dashboard';
  static const String myPatients = '/doctor/my-patients';
  static const String appointments = '/doctor/appointments';
  static const String sessions = '/doctor/sessions';
  static const String clinic = '/doctor/clinic';

  // ─────────────────────────────────────────────────────────────────────────────
  // Shared Routes
  // ─────────────────────────────────────────────────────────────────────────────
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String notFound = '/404';

  /// Initial route (splash or onboarding)
  static const String initial = onboarding;
}

/// Centralized Navigator 1.0 route generator.
///
/// Usage in MaterialApp:
/// ```dart
/// MaterialApp(
///   onGenerateRoute: AppRouter.onGenerateRoute,
///   initialRoute: AppRoutes.initial,
/// )
/// ```
class AppRouter {
  const AppRouter._();

  /// Generate routes from route names.
  ///
  /// Returns the appropriate screen for each route name.
  /// Falls back to [_notFoundScreen] for unknown routes.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name;
    // settings.arguments can be used for passing data between routes

    switch (routeName) {
      // ─────────────────────────────────────────────────────────────────────────
      // Auth Routes
      // ─────────────────────────────────────────────────────────────────────────
      case AppRoutes.onboarding:
        return _buildRoute(settings, const OnboardingNavigationScreens());

      case AppRoutes.login:
        return _buildRoute(settings, const LoginScreen());

      case AppRoutes.selectRole:
        return _buildRoute(settings, const Selectusertypescreen());

      case AppRoutes.registerParent:
        return _buildRoute(settings, const ParentSignUpScreen());

      case AppRoutes.registerDoctor:
        return _buildRoute(settings, const Doctorsignupscreen());

      case AppRoutes.forgotPassword:
        return _buildRoute(settings, const Forgetpasswordscreen());

      case AppRoutes.newPassword:
        return _buildRoute(settings, const CreatenewpasswordScreen());

      case AppRoutes.otpVerification:
        return _buildRoute(settings, const Otpverificationscreen());

      // ─────────────────────────────────────────────────────────────────────────
      // Parent Routes
      // ─────────────────────────────────────────────────────────────────────────
      case AppRoutes.parentHome:
      case AppRoutes.parentDashboard:
        return _buildRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ChildProgressCubit()),
              BlocProvider(
                create: (context) => AvailableEducationArticaleCubit(),
              ),
            ],
            child: const ParentBottomNavgationScreen(),
          ),
        );

      case AppRoutes.autismTest:
        return _buildRoute(settings, const TestSelectionScreen());

      case AppRoutes.childProgress:
        return _buildRoute(settings, const ChildProgressScreen());

      case AppRoutes.education:
        return _buildRoute(settings, const Articles());

      case AppRoutes.chatbot:
        return _buildRoute(settings, const ChatBotscreen());

      case AppRoutes.medicines:
        return _buildRoute(settings, const Availablemedicinescreen());

      case AppRoutes.charity:
        return _buildRoute(settings, const CharityMedicine());

      case AppRoutes.booking:
        // Requires Doctor object as argument
        final doctor = settings.arguments as Doctor?;
        if (doctor == null) {
          return _buildRoute(settings, const _NotFoundScreen());
        }
        return _buildRoute(settings, Reservationscreen(myDoctor: doctor));

      case AppRoutes.bookingPayment:
        // Requires payment arguments
        final args = settings.arguments as BookingPaymentArgs?;
        if (args == null) {
          return _buildRoute(settings, const _NotFoundScreen());
        }
        return _buildRoute(
          settings,
          PaymentType(doctor: args.doctor, sessionData: args.session),
        );

      case AppRoutes.bookingConfirm:
        // Requires booking confirmation arguments
        final args = settings.arguments as BookingConfirmArgs?;
        if (args == null) {
          return _buildRoute(settings, const _NotFoundScreen());
        }
        return _buildRoute(
          settings,
          Confirmreservationscreen(
            DoctorData: args.doctor,
            sessionD: args.session,
          ),
        );

      // ─────────────────────────────────────────────────────────────────────────
      // Doctor Routes
      // ─────────────────────────────────────────────────────────────────────────
      case AppRoutes.doctorHome:
      case AppRoutes.doctorDashboard:
        return _buildRoute(settings, const Doctornavgationscreen());

      // ─────────────────────────────────────────────────────────────────────────
      // Fallback
      // ─────────────────────────────────────────────────────────────────────────
      case AppRoutes.notFound:
      default:
        // Log unknown route for debugging
        debugPrint('⚠️ Unknown route: $routeName');
        return _buildRoute(settings, const _NotFoundScreen());
    }
  }

  /// Build a MaterialPageRoute with the given settings and child widget.
  static MaterialPageRoute<T> _buildRoute<T>(
    RouteSettings settings,
    Widget child,
  ) {
    return MaterialPageRoute<T>(settings: settings, builder: (_) => child);
  }

  /// Helper to navigate with named route.
  static Future<T?> pushNamed<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(context, routeName, arguments: arguments);
  }

  /// Helper to replace current route with named route.
  static Future<T?> pushReplacementNamed<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed<T, dynamic>(
      context,
      routeName,
      arguments: arguments,
    );
  }

  /// Helper to clear stack and push named route.
  static Future<T?> pushNamedAndRemoveUntil<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      (_) => false,
      arguments: arguments,
    );
  }
}

/// Fallback screen for unknown routes (404).
class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              '404',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Page not found',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// Route Argument Classes
// ─────────────────────────────────────────────────────────────────────────────

/// Arguments for the booking payment route.
class BookingPaymentArgs {
  final Doctor doctor;
  final BookSession session;

  const BookingPaymentArgs({required this.doctor, required this.session});
}

/// Arguments for the booking confirmation route.
class BookingConfirmArgs {
  final Doctor doctor;
  final BookSession session;

  const BookingConfirmArgs({required this.doctor, required this.session});
}
