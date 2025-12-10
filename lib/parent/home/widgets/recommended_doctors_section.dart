import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/controllers/doctors_list_cubit.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/controllers/doctors_list_state.dart';
import 'package:asdsmartcare/parent/home/widgets/doctor_card.dart';
import 'package:asdsmartcare/parent/home/widgets/doctor_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Section displaying recommended doctors with all states.
class RecommendedDoctorsSection extends StatelessWidget {
  const RecommendedDoctorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorsListCubit, GetDoctorsListStates>(
      builder: (context, state) {
        final cubit = DoctorsListCubit.get(context);

        if (state is GetDoctorsListLoadingState) {
          return _buildLoadingState();
        }

        if (state is GetDoctorsListFailedState) {
          return _buildErrorState(context);
        }

        if (cubit.myDoctorList.isEmpty) {
          return _buildEmptyState();
        }

        return _buildDoctorsList(context, cubit);
      },
    );
  }

  Widget _buildLoadingState() {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (_, __) => const DoctorCardShimmer(),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: ErrorView(
        message: 'Failed to load specialists',
        onRetry: () => context.read<DoctorsListCubit>().getDoctorsList(
          recommendedDoctor: true,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: EmptyView(message: 'No specialists found at the moment.'),
    );
  }

  Widget _buildDoctorsList(BuildContext context, DoctorsListCubit cubit) {
    final doctors = cubit.myDoctorList.take(5).toList();

    return SizedBox(
      height: 250,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: doctors.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return DoctorCard(
            name: doctor.parent?.userName ?? 'Dr. Unknown',
            specialization: doctor.speciailization ?? 'Specialist',
            rating: doctor.ratingsAverage?.toDouble() ?? 0.0,
            imageUrl: doctor.image,
            isTopRated: index == 0,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.booking,
                arguments: doctor,
              );
            },
          );
        },
      ),
    );
  }
}
