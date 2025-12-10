import 'package:asdsmartcare/parent/account/controllers/parent_profile_cubit.dart';
import 'package:asdsmartcare/parent/account/controllers/parent_profile_state.dart';
import 'package:asdsmartcare/parent/account/views/widgets/parent_profile_body.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentProfileScreen extends StatelessWidget {
  /// Optional cubit for testing. If not provided, creates a new one.
  final GetParentDataCubit? cubit;

  const ParentProfileScreen({super.key, this.cubit});

  @override
  Widget build(BuildContext context) {
    // Use injected cubit or create a new one
    if (cubit != null) {
      return BlocProvider<GetParentDataCubit>.value(
        value: cubit!,
        child: BlocBuilder<GetParentDataCubit, GetParentDataStates>(
          builder: (context, state) {
            return Scaffold(body: _buildBody(context, cubit!, state));
          },
        ),
      );
    }

    return BlocProvider(
      create: (_) => GetParentDataCubit()..getParentData(),
      child: BlocBuilder<GetParentDataCubit, GetParentDataStates>(
        builder: (context, state) {
          final cubit = GetParentDataCubit.get(context);

          return Scaffold(body: _buildBody(context, cubit, state));
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    GetParentDataCubit cubit,
    GetParentDataStates state,
  ) {
    if (state is GetParentDataLoadingStates) {
      return const LoadingView(message: 'Retrieving your profile...');
    }

    if (state is GetParentDataFailedStates) {
      return ErrorView(
        message: 'Unable to load profile data. Please try again.',
        onRetry: () => cubit.getParentData(),
      );
    }

    if (cubit.currentParent == null) {
      return EmptyView(
        title: 'No Profile Found',
        message: 'We couldn\'t find your profile details.',
        onAction: () => cubit.getParentData(),
        actionText: 'Retry',
      );
    }

    return ParentProfileBody(cubit: cubit, state: state);
  }
}
