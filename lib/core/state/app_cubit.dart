import 'package:asdsmartcare/core/state/app_state.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/views/doctors_list_screen.dart';
import 'package:asdsmartcare/parent/home/parent_home_screen.dart';
import 'package:asdsmartcare/parent/screening/views/test_selection/test_selection_screen.dart';
import 'package:asdsmartcare/parent/progress/views/progress_screen.dart';
import 'package:asdsmartcare/parent/account/views/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsdCubit extends Cubit<AsdStates> {
  AsdCubit() : super(AsdInitialState());

  static AsdCubit get(context) => BlocProvider.of(context);
  int current_index = 0;

  List ParentBottomNavgation = [
    const ParentHomeScreen(),
    const DoctorsListPage(),
    const TestSelectionScreen(),
    const ChildProgressScreen(),
    const ParentProfileScreen(),
  ];

  List DoctorBottomNavgation = [
    'home',
    'clinic',
    'sessions',
    'appointments',
    'profile',
  ];

  void Reset() {
    emit(AsdInitialState());
  }

  void change_index(int val) {
    current_index = val;
    emit(AsdChangIindexState());
  }
}
