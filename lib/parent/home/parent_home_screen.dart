import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/controllers/doctors_list_cubit.dart';
import 'package:asdsmartcare/parent/home/widgets/widgets.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Parent home screen - main dashboard for parents.
///
/// Redesigned with "Care Horizon" concept:
/// - [DynamicGreeting] - Time-based greeting
/// - [CarePulseCard] - Dynamic hero card for sessions/CTA
/// - [ServiceOrbit] - Modern service quick access
/// - [RecommendedDoctorsSection] - Specialist recommendations
class ParentHomeScreen extends StatefulWidget {
  final DoctorsListCubit? doctorsCubit;

  const ParentHomeScreen({super.key, this.doctorsCubit});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final userId = CacheHelper.getData(key: 'id');
    if (userId != null) {
      context
          .read<ChildProgressCubit>()
          .GetAllCommingSessionsBookedaSpecificParent(userId, true);
    }
    context.read<DoctorsListCubit>().getDoctorsList(recommendedDoctor: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              widget.doctorsCubit ??
              (DoctorsListCubit()..getDoctorsList(recommendedDoctor: true)),
        ),
        BlocProvider.value(value: context.read<ChildProgressCubit>()),
      ],
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _loadInitialData,
          color: AppColors.primary,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              const SliverToBoxAdapter(
                  child: SafeArea(bottom: false, child: DynamicGreeting())),
              const SliverToBoxAdapter(child: CarePulseCard()),
              const SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Quick Services',
                  padding: EdgeInsets.fromLTRB(AppSpacing.xl, AppSpacing.lg,
                      AppSpacing.xl, AppSpacing.md),
                ),
              ),
              const SliverToBoxAdapter(child: ServiceOrbit()),
              const SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Top Specialists',
                  actionLabel: 'View All',
                  onActionPressed: null, // Add navigation if needed
                  padding: EdgeInsets.fromLTRB(AppSpacing.xl, AppSpacing.xl,
                      AppSpacing.xl, AppSpacing.md),
                ),
              ),
              const SliverToBoxAdapter(child: RecommendedDoctorsSection()),
              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
            ],
          ),
        ),
      ),
    );
  }
}
