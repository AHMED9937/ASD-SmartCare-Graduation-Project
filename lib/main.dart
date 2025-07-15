// lib/main.dart

import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/Components/myblockob.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/presentation/AsdAppLayouts/screens/ParentNavgationScreen.dart';
import 'package:asdsmartcare/presentation/AsdAppLayouts/screens/DoctorNavgationScreen.dart';
import 'package:asdsmartcare/presentation/SignUp/screen/DoctorSignUpScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/onBoarding/onboardingNavgationaScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/AsdAppLayouts/cubit/asd_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  Diohelper.init();

  // Read persisted values
  final bool? onBoarding  = CacheHelper.getData(key: "loginSingUp");
  final String? token     = CacheHelper.getData(key: "token");
  final bool? rememberMe  = CacheHelper.getData(key: "rememberMe");
  final String? role      = CacheHelper.getData(key: "role");

  runApp(MyApp(
    onBoarding: onBoarding,
    token: token,
    rememberMe: rememberMe,
    role: role,
  ));
}

class MyApp extends StatelessWidget {
  final bool? onBoarding;
  final String? token;
  final bool? rememberMe;
  final String? role;

  const MyApp({
    Key? key,
    this.onBoarding,
    this.token,
    this.rememberMe,
    this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Decide start screen
    Widget startScreen;
    if (onBoarding != true) {
      startScreen = OnboardingNavigationScreens();
    } else if (token != null && rememberMe == true) {
      if (role == 'doctor') {
        startScreen = Doctornavgationscreen();
      } else {
        startScreen = ParentBottomNavgationScreen();
      }
    } else {
      startScreen = Loginscreen();
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AsdCubit()),
      ],
      child: MaterialApp(
        title: 'ASD Smart Care',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          // Keep your accent as blue
          primaryColor: const Color(0xFF133E87),
          colorScheme: ThemeData.light().colorScheme.copyWith(
            primary: const Color(0xFF133E87),
            secondary: const Color(0xFF133E87),
            background: Colors.white,
            surface: Colors.white,
          ),

          // Surfaces and backgrounds
          scaffoldBackgroundColor: Colors.white,
          canvasColor: Colors.white,
          cardColor: Colors.white,
          dialogBackgroundColor: Colors.white,

          // AppBar
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold
            ),
            elevation: 0,
          ),

          // Bottom Navigation
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            elevation: 8,
            selectedItemColor: Color(0xFF133E87),
            unselectedItemColor: Colors.grey,
            selectedIconTheme: IconThemeData(size: 28),
            unselectedIconTheme: IconThemeData(size: 24),
            showUnselectedLabels: true,
          ),

          // ElevatedButtons
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF133E87),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          // FloatingActionButtons
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF133E87),
            foregroundColor: Colors.white,
            elevation: 0,
          ),

          // Progress indicators
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(0xFF133E87),
          ),

          // Text defaults
          textTheme: Typography.blackMountainView,

          // Inputs
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        home: OnboardingNavigationScreens(),
      ),
    );
  }
}
