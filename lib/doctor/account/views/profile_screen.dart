import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/account/controllers/doctor_profile_cubit.dart';
import 'package:asdsmartcare/doctor/account/controllers/doctor_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/doctor_profile_body.dart';

/// Redesigned Doctor Profile screen following SOLID principles.
class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MeshGradientBackground(
      child: BlocProvider(
        create: (context) => GetDoctorDataCubit()..getDoctorData(),
        child: BlocBuilder<GetDoctorDataCubit, GetDoctorDataStates>(
          builder: (context, state) {
            final cubit = GetDoctorDataCubit.get(context);

            return Scaffold(
              backgroundColor: Colors.transparent, // Allow gradient to show
              body: _buildBody(context, cubit, state),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    GetDoctorDataCubit cubit,
    GetDoctorDataStates state,
  ) {
    if (state is GetDoctorDataLoadingStates) {
      return const LoadingView(message: 'Retrieving your profile...');
    }

    if (state is GetDoctorDataFailedStates) {
      return ErrorView(
        message: 'Unable to load profile data. Please try again.',
        onRetry: () => cubit.getDoctorData(),
      );
    }

    if (cubit.currentDoctor == null) {
      return EmptyView(
        title: 'No Profile Found',
        message: 'We couldn\'t find your profile details.',
        onAction: () => cubit.getDoctorData(),
        actionText: 'Retry',
      );
    }

    return DoctorProfileBody(cubit: cubit, state: state);
  }
}
