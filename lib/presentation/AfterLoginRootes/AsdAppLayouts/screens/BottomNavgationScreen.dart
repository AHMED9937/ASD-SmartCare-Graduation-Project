import 'package:asdsmartcare/presentation/AfterLoginRootes/AsdAppLayouts/cubit/asd_cubit.dart';
import 'package:asdsmartcare/presentation/AfterLoginRootes/AsdAppLayouts/cubit/asd_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bottomnavgationscreen extends StatelessWidget {
  const Bottomnavgationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AsdCubit, AsdStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: NavigationBar(
            selectedIndex: AsdCubit.get(context).current_index,
            destinations: const [
              NavigationDestination(
                icon: Icon(
                  Icons.home,
                  color: Color(0xFF133E87),
                ),
                label: 'home',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.health_and_safety,
                  color: Color(0xFF133E87),
                ),
                label: 'doctor',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.chat_bubble,
                  color: Color(0xFF133E87),
                ),
                label: 'chat',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.account_circle,
                  color: Color(0xFF133E87),
                ),
                label: 'profile',
              ),
            ],
            onDestinationSelected: (index) {
              AsdCubit.get(context).change_index(index);
            },
          ),
          body: AsdCubit.get(context).MyAppBottomNavgation[AsdCubit.get(context).current_index],
        );
      },
    );
  }
}
