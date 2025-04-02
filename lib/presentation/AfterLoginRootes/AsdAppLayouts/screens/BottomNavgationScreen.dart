import 'package:asdsmartcare/presentation/AfterLoginRootes/AsdAppLayouts/cubit/asd_cubit.dart';
import 'package:asdsmartcare/presentation/AfterLoginRootes/AsdAppLayouts/cubit/asd_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bottomnavgationscreen extends StatelessWidget {
  const Bottomnavgationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AsdCubit, AsdStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: NavigationBar(
            backgroundColor: Colors.white,
            indicatorColor: Colors.white,
            selectedIndex: AsdCubit.get(context).current_index,
            destinations: [
              NavigationDestination(
                
                icon: Image(
                  color: AsdCubit.get(context).current_index == 0
                      ? Color(0xFF133E87)
                      : Colors.grey,
                  image: AssetImage(
                      'lib/appassets/images/homeOnboarding.png'), // Path to your local image
                  width: 33, // Specify width
                  height: 25, // Specify height
                ),
                label: 'home',
              ),
              NavigationDestination(
                icon: Image(
                  color: AsdCubit.get(context).current_index == 1
                      ? Color(0xFF133E87)
                      : Colors.grey,
                  image: AssetImage(
                      'lib/appassets/images/doctorOnboarding.png'), // Path to your local image
                  width: 33, // Specify width
                  height: 25, // Specify height
                ),
                label: 'doctors',
              ),
              NavigationDestination(
                icon: Image(
                  color: AsdCubit.get(context).current_index == 2
                      ? Color(0xFF133E87)
                      : Colors.grey,
                  image: AssetImage(
                      'lib/appassets/images/evaluate.png'), // Path to your local image
                  width: 33, // Specify width
                  height: 25, // Specify height
                ),
                label: 'Evaluate',
              ),
              NavigationDestination(
                icon: Image(
                  color: AsdCubit.get(context).current_index == 3
                      ? Color(0xFF133E87)
                      : Colors.grey,
                  image: AssetImage(
                      'lib/appassets/images/progressonboardin.png'), // Path to your local image
                  width: 33, // Specify width
                  height: 25, // Specify height
                ),
                label: 'progress',
              ),
              NavigationDestination(
                icon:  Image(
                  color: AsdCubit.get(context).current_index == 4
                      ? Color.fromARGB(255, 19, 62, 135)
                      : Colors.grey,
                  image: AssetImage(
                      'lib/appassets/images/profile.png'), // Path to your local image
                  width: 30, // Specify width
                  height: 30, // Specify height
                ),
                label: 'profile',
              ),
            ],
            onDestinationSelected: (index) {
              AsdCubit.get(context).change_index(index);
            },
          ),
          body:
          Padding(padding: EdgeInsets.fromLTRB(15,15,15,0),
          child: AsdCubit.get(context).MyAppBottomNavgation[AsdCubit.get(context).current_index],
           
          )
        );
      },
    );
  }
}
