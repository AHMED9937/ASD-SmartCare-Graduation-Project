import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/medicines/controllers/medicines_cubit.dart';
import 'package:asdsmartcare/shared/medicines/controllers/medicines_state.dart';
import 'package:asdsmartcare/shared/medicines/views/widgets/medicine_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicinesBody extends StatelessWidget {
  const MedicinesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AvailableMedicineCubit.get(context);

    return BlocBuilder<AvailableMedicineCubit, AvailableMedicineState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async => cubit.getAvailableMedicine(),
          child: Column(
            children: [
              // Search & Info Header
              _buildHeader(context, cubit),

              // Results Area
              Expanded(child: _buildContent(context, state, cubit)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, AvailableMedicineCubit cubit) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(color: AppColors.transparent),
      child: Column(
        children: [
          const Text(
            'Search for medicine and pharmacy to find treatment',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const AppSpacer.md(),
          AppSearchField(
            hint: 'Search medicine...',
            onChanged: (value) {
              if (value.length >= 2 || value.isEmpty) {
                cubit.searchMedicine(value);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    AvailableMedicineState state,
    AvailableMedicineCubit cubit,
  ) {
    if (state is GetAvailableMedicineLoading) {
      return const Center(child: LoadingView());
    }

    if (state is GetAvailableMedicineError) {
      return ErrorView(
        message: state.error,
        onRetry: () => cubit.getAvailableMedicine(),
      );
    }

    if (cubit.items.isEmpty) {
      return const EmptyView(
        message: 'No medicines found. Try a different search.',
        icon: Icons.medication_outlined,
      );
    }

    return ResponsivePadding(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        itemCount: cubit.items.length,
        separatorBuilder: (_, __) => const AppSpacer.md(),
        itemBuilder: (context, index) {
          return MedicineCard(medicine: cubit.items[index]);
        },
      ),
    );
  }
}
