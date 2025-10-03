import 'package:asdsmartcare/core/state/app_state.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/views/doctors_list_screen.dart';
import 'package:asdsmartcare/parent/home/parent_home_screen.dart';
import 'package:asdsmartcare/parent/screening/views/test_selection/test_selection_screen.dart';
import 'package:asdsmartcare/parent/progress/views/progress_screen.dart';
import 'package:asdsmartcare/parent/account/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsdCubit extends Cubit<AsdStates> {
  AsdCubit() : super(AsdInitialState());

  static AsdCubit get(BuildContext context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> parentBottomNavigation = [
    const ParentHomeScreen(),
    const DoctorsListPage(),
    const TestSelectionScreen(),
    const ChildProgressScreen(),
    const ParentProfileScreen(),
  ];

  List<String> doctorBottomNavigation = [
    'home',
    'clinic',
    'sessions',
    'appointments',
    'profile',
  ];

  void reset() {
    emit(AsdInitialState());
  }

  void changeIndex(int val) {
    currentIndex = val;
    emit(AsdChangIindexState());
  }
}
