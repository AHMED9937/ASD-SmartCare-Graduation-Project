import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/account/controllers/edit_profile_cubit.dart';
import 'package:asdsmartcare/doctor/account/controllers/edit_profile_state.dart';
import 'package:asdsmartcare/doctor/account/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/edit_doctor_profile_body.dart';

/// Redesigned Doctor Profile Editor following SOLID principles.
class EditDoctorProfileScreen extends StatelessWidget {
  final GetLoggedDoctorData DoctorD;
  final EditDoctorProfileCubit? cubit;

  const EditDoctorProfileScreen({
    super.key,
    required this.DoctorD,
    this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit ?? (EditDoctorProfileCubit()..initFrom(DoctorD)),
      child: BlocConsumer<EditDoctorProfileCubit, EditDoctorProfileState>(
        listener: (context, state) {
          if (state is EditDoctorProfileSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            Navigator.of(context).pop();
          }
          if (state is EditDoctorProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = EditDoctorProfileCubit.get(context);

          return Scaffold(
            appBar: const AppHeader(
              title: 'Edit Profile',
              showBackButton: true,
            ),
            body: EditDoctorProfileBody(
              cubit: cubit,
              state: state,
              originalImageUrl: DoctorD.data?.image,
            ),
          );
        },
      ),
    );
  }
}
