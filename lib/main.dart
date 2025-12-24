// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/design_system/theme.dart';
import 'package:asdsmartcare/core/ui/backgrounds/mesh_gradient_background.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:asdsmartcare/core/state/app_cubit.dart';
import 'package:asdsmartcare/core/state/bloc_observer.dart';
import 'package:asdsmartcare/doctor/navigation/doctor_navigation_screen.dart';
import 'package:asdsmartcare/parent/navigation/parent_navigation_screen.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_cubit.dart';
import 'package:asdsmartcare/shared/auth/login/views/login_screen.dart';
import 'package:asdsmartcare/shared/auth/onboarding/views/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Stripe
  Stripe.publishableKey = ApiConstants.stripePublishableKey;
  await Stripe.instance.applySettings();

  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  Diohelper.init();

  // Read persisted values
  final bool? onBoarding = CacheHelper.getData(key: 'loginSingUp');
  final String? token = CacheHelper.getData(key: 'token');
  final bool? rememberMe = CacheHelper.getData(key: 'rememberMe');
  final String? role = CacheHelper.getData(key: 'role');

  runApp(MyApp(
    onBoarding: onBoarding,
    token: token,
    rememberMe: rememberMe,
    role: role,
  ));
}

/// Root application widget.
///
/// Configures:
/// - Theme from design system tokens [AppTheme.light]
/// - Router via [AppRouter.onGenerateRoute]
/// - Global BLoC providers
class MyApp extends StatelessWidget {
  final bool? onBoarding;
  final String? token;
  final bool? rememberMe;
  final String? role;

  const MyApp({
    super.key,
    this.onBoarding,
    this.token,
    this.rememberMe,
    this.role,
  });

  @override
  Widget build(BuildContext context) {
    // Determine initial route based on cached state
    final String initialRoute = _determineInitialRoute();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AsdCubit()),
        BlocProvider(create: (_) => ChildProgressCubit()),
      ],
      child: MaterialApp(
        title: 'ASD Smart Care',
        debugShowCheckedModeBanner: false,

        // Use centralized theme from design system
        theme: AppTheme.light,

        // Use centralized routing
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: initialRoute,

        // Fallback home (used when initialRoute is not set)
        home: _buildInitialScreen(),

        // Apply global background
        builder: (context, child) {
          return MeshGradientBackground(child: child);
        },
      ),
    );
  }

  /// Determine the initial route based on cached user state.
  String _determineInitialRoute() {
    if (onBoarding != true) {
      return AppRoutes.onboarding;
    } else if (token != null && rememberMe == true) {
      if (role == 'doctor') {
        return AppRoutes.doctorHome;
      } else {
        return AppRoutes.parentHome;
      }
    } else {
      return AppRoutes.login;
    }
  }

  /// Build the initial screen widget (fallback for home property).
  Widget _buildInitialScreen() {
    if (onBoarding != true) {
      return const OnboardingNavigationScreens();
    } else if (token != null && rememberMe == true) {
      if (role == 'doctor') {
        return const Doctornavgationscreen();
      } else {
        return const ParentBottomNavgationScreen();
      }
    } else {
      return const LoginScreen();
    }
  }
}
