import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asdsmartcare/appShared/Components/myblockob.dart';
import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/presentation/AsdAppLayouts/cubit/asd_cubit.dart';
import 'package:asdsmartcare/presentation/AsdAppLayouts/screens/DoctorNavgationScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  Diohelper.init();

  bool? onBoarding = CacheHelper.getData(key: "loginSingUp");
  String? token = CacheHelper.getData(key: "token");

  runApp(MyApp(onBoarding: onBoarding));
}

class MyApp extends StatelessWidget {
  final bool? onBoarding;
  const MyApp({Key? key, this.onBoarding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AsdCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            elevation: 8,
            selectedItemColor: Color(0xFF133E87),
            unselectedItemColor: Colors.grey,
            selectedIconTheme: IconThemeData(size: 28),
            unselectedIconTheme: IconThemeData(size: 24),
            showUnselectedLabels: true,
          ),
          primaryColor: const Color(0xFF133E87),
        ),
        home:  Doctornavgationscreen(),
      ),
    );
  }
}
