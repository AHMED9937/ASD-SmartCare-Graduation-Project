import 'package:asdsmartcare/appShared/Components/myblockob.dart';
import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/presentation/AfterLoginRootes/AsdAppLayouts/cubit/asd_cubit.dart';
import 'package:asdsmartcare/presentation/login/screen/SelectUserTypeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures asynchronous operations work in main()
  await  CacheHelper.init(); // Initialize CacheHelper
  Bloc.observer = MyBlocObserver();
  Diohelper.init();
  bool? onBoarding = CacheHelper.getData(key: "loginSingUp");
  String? token = CacheHelper.getData(key: "token");
  //print(token);
  
  runApp(
       MyApp(onBoardin: onBoarding),
    
  );
}

class MyApp extends StatefulWidget {
  final bool? onBoardin;
  const MyApp({super.key, required this.onBoardin});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AsdCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        // Add the DevicePreview builder to allow preview functionality in the app.
        
        builder: DevicePreview.appBuilder,
        home: Selectusertypescreen(),
      ),
    );
  }
}
