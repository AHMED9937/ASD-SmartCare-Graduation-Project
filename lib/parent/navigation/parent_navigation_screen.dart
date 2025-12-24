import 'package:asdsmartcare/core/state/app_cubit.dart';
import 'package:asdsmartcare/core/state/app_state.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentBottomNavgationScreen extends StatelessWidget {
  const ParentBottomNavgationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AsdCubit, AsdStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = AsdCubit.get(context);
        return Scaffold(
            bottomNavigationBar: NavigationBar(
              backgroundColor: AppColors.surface,
              indicatorColor: AppColors.surface,
              selectedIndex: cubit.current_index,
              destinations: [
                _buildNavDestination(
                  index: 0,
                  currentIndex: cubit.current_index,
                  imagePath: 'lib/appassets/images/homeOnboarding.png',
                  label: 'home',
                ),
                _buildNavDestination(
                  index: 1,
                  currentIndex: cubit.current_index,
                  imagePath: 'lib/appassets/images/doctorOnboarding.png',
                  label: 'doctors',
                ),
                _buildNavDestination(
                  index: 2,
                  currentIndex: cubit.current_index,
                  imagePath: 'lib/appassets/images/evaluate.png',
                  label: 'Evaluate',
                ),
                _buildNavDestination(
                  index: 3,
                  currentIndex: cubit.current_index,
                  imagePath: 'lib/appassets/images/progressonboardin.png',
                  label: 'progress',
                ),
                _buildNavDestination(
                  index: 4,
                  currentIndex: cubit.current_index,
                  imagePath: 'lib/appassets/images/profile.png',
                  label: 'profile',
                  width: 30,
                  height: 30,
                ),
              ],
              onDestinationSelected: (index) {
                cubit.change_index(index);
              },
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md, // 15 -> ~12
                AppSpacing.md,
                AppSpacing.md,
                0,
              ),
              child: cubit.ParentBottomNavgation[cubit.current_index],
            ));
      },
    );
  }

  NavigationDestination _buildNavDestination({
    required int index,
    required int currentIndex,
    required String imagePath,
    required String label,
    double width = 33,
    double height = 25,
  }) {
    final isSelected = currentIndex == index;
    return NavigationDestination(
      icon: Image(
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
        image: AssetImage(imagePath),
        width: width,
        height: height,
      ),
      label: label,
    );
  }
}
