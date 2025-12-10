import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

import 'package:asdsmartcare/parent/find_doctors/browse/controllers/doctors_list_cubit.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/controllers/doctors_list_state.dart';
import 'widgets/doctor_card.dart';
import 'widgets/doctors_list_header.dart';

/// Premium Doctors List Screen with an immersive design and smooth interactions.
class DoctorsListPage extends StatelessWidget {
  final DoctorsListCubit? cubit;
  const DoctorsListPage({super.key, this.cubit});

  @override
  Widget build(BuildContext context) {
    const body = DoctorsListBody();

    return cubit != null
        ? BlocProvider.value(value: cubit!, child: body)
        : BlocProvider(
            create: (_) => DoctorsListCubit()..getDoctorsList(),
            child: body,
          );
  }
}

class DoctorsListBody extends StatelessWidget {
  const DoctorsListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<DoctorsListCubit, GetDoctorsListStates>(
          builder: (context, state) {
            final cubitInstance = DoctorsListCubit.get(context);

            if (state is GetDoctorsListLoadingState) {
              return const LoadingView(message: 'Finding best specialists...');
            }

            if (state is GetDoctorsListFailedState) {
              return ErrorView(
                message: 'Unable to load specialists.',
                onRetry: () => cubitInstance.getDoctorsList(),
              );
            }

            final doctors = cubitInstance.myDoctorList;

            if (doctors.isEmpty) {
              return EmptyView.search(
                onAction: () => cubitInstance.getDoctorsList(),
              );
            }

            return RefreshIndicator(
              onRefresh: () async => cubitInstance.getDoctorsList(),
              displacement: 80,
              color: AppColors.primary,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  const _SliverHeader(),
                  const _SliverSearch(),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    sliver: ResponsiveContainer.sliverBuilder(
                      sliverBuilder: (context, breakpoint) {
                        final isGrid =
                            breakpoint == DeviceBreakpoint.desktop ||
                            breakpoint == DeviceBreakpoint.tablet;

                        if (isGrid) {
                          return SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      breakpoint == DeviceBreakpoint.desktop
                                      ? 3
                                      : 2,
                                  mainAxisSpacing: AppSpacing.md,
                                  crossAxisSpacing: AppSpacing.md,
                                  childAspectRatio: 2.2,
                                ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  DoctorCard(doctor: doctors[index]),
                              childCount: doctors.length,
                            ),
                          );
                        }

                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                                DoctorCard(doctor: doctors[index]),
                            childCount: doctors.length,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SliverHeader extends StatelessWidget {
  const _SliverHeader();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [AppHeader(showBackButton: false), DoctorsListHeader()],
      ),
    );
  }
}

class _SliverSearch extends StatelessWidget {
  const _SliverSearch();

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _FloatingSearchDelegate(),
    );
  }
}

class _FloatingSearchDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withValues(
          alpha: overlapsContent ? 0.95 : 0.0,
        ),
      ),
      child: const AppSearchField(hint: 'Search by specialty or name...'),
    );
  }

  @override
  double get maxExtent => 72;

  @override
  double get minExtent => 72;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
