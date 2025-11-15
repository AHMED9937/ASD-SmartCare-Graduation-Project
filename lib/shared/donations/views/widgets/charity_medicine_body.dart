import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/donations/controllers/charity_cubit.dart';
import 'package:asdsmartcare/shared/donations/controllers/charity_state.dart';
import 'package:asdsmartcare/shared/donations/views/widgets/charity_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharityMedicineBody extends StatelessWidget {
  const CharityMedicineBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AvailableCharityCubit.get(context);

    return BlocBuilder<AvailableCharityCubit, AvailableCharityState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async => cubit.getAvailableCharity(),
          child: Column(
            children: [
              // Search & Info Header
              _buildHeader(context, cubit),

              // Results Area
              Expanded(
                child: _buildContent(context, state, cubit),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, AvailableCharityCubit cubit) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.transparent,
      ),
      child: Column(
        children: [
          const Text(
            'Search for charities by location to find support',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const AppSpacer.md(),
          AppSearchField(
            hint: 'Search by address...',
            onChanged: (value) {
              if (value.length >= 2 || value.isEmpty) {
                cubit.searchCharity(value);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    AvailableCharityState state,
    AvailableCharityCubit cubit,
  ) {
    if (state is GetAvailableCharityLoading) {
      return const Center(child: LoadingView());
    }

    if (state is GetAvailableCharityError) {
      return ErrorView(
        message: state.error,
        onRetry: () => cubit.getAvailableCharity(),
      );
    }

    final items = cubit.items;
    if (items.isEmpty) {
      return const EmptyView(
        message: 'No charities found in this area.',
        icon: Icons.volunteer_activism_outlined,
      );
    }

    return ResponsivePadding(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        itemCount: items.length,
        separatorBuilder: (_, __) => const AppSpacer.md(),
        itemBuilder: (context, index) {
          return CharityCard(charity: items[index]);
        },
      ),
    );
  }
}
