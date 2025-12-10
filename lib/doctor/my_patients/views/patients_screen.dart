import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/my_patients/views/widgets/patient_card.dart';
import 'package:asdsmartcare/doctor/my_patients/views/widgets/patient_details_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asdsmartcare/doctor/my_patients/controllers/patients_list_cubit.dart';
import 'package:asdsmartcare/doctor/my_patients/controllers/patients_list_state.dart';

/// Screen showing all registered children and, on tap, detailed bottom sheet.
class RegisteredChildrenScreen extends StatelessWidget {
  const RegisteredChildrenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisteredChildrenListCubit()..getRegisteredChildrenList(),
      child: const RegisteredChildrenView(),
    );
  }
}

class RegisteredChildrenView extends StatelessWidget {
  const RegisteredChildrenView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(showBackButton: false),
            PageHeader(
              title: 'Registered Children',
              subtitle: 'Manage and view details of children under your care.',
            ),
            Expanded(child: _PatientsBody()),
          ],
        ),
      ),
    );
  }
}

class _PatientsBody extends StatelessWidget {
  const _PatientsBody();

  void _showDetails(BuildContext context, dynamic parent, dynamic child) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<RegisteredChildrenListCubit>(),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return PatientDetailsSheet(
              parent: parent,
              child: child,
              scrollController: scrollController,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      RegisteredChildrenListCubit,
      GetRegisteredChildrenListStates
    >(
      builder: (context, state) {
        final cubit = RegisteredChildrenListCubit.get(context);

        if (state is GetRegisteredChildrenListLoadingStates) {
          return const LoadingView(message: 'Loading patients...');
        }

        if (state is GetRegisteredChildrenListFailedStates) {
          return ErrorView(
            message: 'Failed to load registered children.',
            onRetry: () => cubit.getRegisteredChildrenList(),
          );
        }

        final parents = cubit.registeredchildren?.parents;
        final validParents = (parents != null && parents.isNotEmpty)
            ? parents
                  .where((p) => p.childs != null && p.childs!.isNotEmpty)
                  .toList()
            : [];

        if (validParents.isEmpty) {
          return const EmptyView(
            title: 'No patients found',
            message: 'You don\'t have any registered children at the moment.',
            icon: Icons.people_outline_rounded,
          );
        }

        return RefreshIndicator(
          onRefresh: () async => cubit.getRegisteredChildrenList(),
          color: AppColors.primary,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            itemCount: validParents.length,
            itemBuilder: (context, index) {
              final parent = validParents[index];
              final child = parent.childs!.first;

              return PatientCard(
                parent: parent,
                child: child,
                onTap: () => _showDetails(context, parent, child),
              );
            },
          ),
        );
      },
    );
  }
}
