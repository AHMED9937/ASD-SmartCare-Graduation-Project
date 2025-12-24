import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/account/controllers/edit_profile_cubit.dart';
import 'package:asdsmartcare/parent/account/controllers/edit_profile_state.dart';
import 'package:asdsmartcare/parent/account/models/parent_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/edit_parent_profile_body.dart';

/// Redesigned Parent Profile Editor following SOLID principles.
class EditParentProfileScreen extends StatelessWidget {
  final GetLoggedParentData parentD;
  final EditParentProfileCubit? cubit;

  const EditParentProfileScreen({
    super.key,
    required this.parentD,
    this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit ?? (EditParentProfileCubit()..initFrom(parentD)),
      child: BlocConsumer<EditParentProfileCubit, EditParentProfileState>(
        listener: (context, state) {
          if (state is EditParentProfileSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            Navigator.of(context).pop();
          }
          if (state is EditParentProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = EditParentProfileCubit.get(context);

          return Scaffold(
            appBar: const AppHeader(
              title: 'Edit Profile',
              showBackButton: true,
            ),
            body: EditParentProfileBody(
              cubit: cubit,
              state: state,
              originalImageUrl: parentD.data?.image,
              parentId: parentD.data?.id ?? '',
            ),
          );
        },
      ),
    );
  }
}
