import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_cubit.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_state.dart';
import 'progress_overview_card.dart';
import 'doctor_navigation.dart';
import 'session_type_tabs.dart';
import 'session_card.dart';
import 'package:asdsmartcare/parent/screening/views/test_selection/test_selection_screen.dart';

/// The main content area of the Parent Progress screen.
/// Orchestrates the different sections and UI states.
class ChildProgressBody extends StatelessWidget {
  final ChildProgressCubit cubit;
  final ChildProgressState state;
  final int selectedTabIndex;
  final ValueChanged<int> onTabChanged;
  final VoidCallback onNextDoctor;
  final VoidCallback onPreviousDoctor;

  const ChildProgressBody({
    super.key,
    required this.cubit,
    required this.state,
    required this.selectedTabIndex,
    required this.onTabChanged,
    required this.onNextDoctor,
    required this.onPreviousDoctor,
  });

  @override
  Widget build(BuildContext context) {
    // Show full-page loader ONLY on the very first load (when doctors list hasn't been initialized)
    // Subsequent reloads or tab switches will use local section loaders instead.
    final isInitialLoading = state is UnifiedProgressDataLoading &&
        (cubit.myDoctorList == null || cubit.myDoctorList!.isEmpty);

    if (isInitialLoading) {
      return const Center(child: LoadingView());
    }

    if (state is UnifiedProgressDataError) {
      return ErrorView(
        message: 'Failed to load progress data',
        onRetry: () => cubit.InitialFetchUnifiedData(selectedTabIndex == 1),
      );
    }

    return ResponsivePadding(
      child: RefreshIndicator(
        onRefresh: () async =>
            cubit.InitialFetchUnifiedData(selectedTabIndex == 1),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Overview Section
              _buildSectionTitle('Assessment Overview'),
              const SizedBox(height: AppSpacing.md),
              _buildProgressOverview(context),
              const SizedBox(height: AppSpacing.xl),

              // 2. Doctor Navigation Section
              _buildSectionTitle('Progress with Specialist'),
              const SizedBox(height: AppSpacing.md),
              if (cubit.myDoctorList == null || cubit.myDoctorList!.isEmpty)
                const EmptyView(
                  message: 'No specialists booked yet.',
                  icon: Icons.person_off_outlined,
                )
              else
                DoctorNavigation(
                  doctorName:
                      cubit.myDoctorList![cubit.current].parent?.userName ??
                          'Unknown Doctor',
                  onPrevious: onPreviousDoctor,
                  onNext: onNextDoctor,
                  hasPrevious: cubit.current > 0,
                  hasNext: cubit.current < cubit.myDoctorList!.length - 1,
                ),
              const SizedBox(height: AppSpacing.xl),

              // 3. Sessions Section
              _buildSectionTitle('Observations & History'),
              const SizedBox(height: AppSpacing.md),
              SessionTypeTabs(
                selectedIndex: selectedTabIndex,
                tabNames: const ['Sessions Done', 'Upcoming Sessions'],
                onTabChanged: onTabChanged,
              ),
              const SizedBox(height: AppSpacing.lg),

              // 4. Session List State Handling
              _buildSessionListContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTypography.titleLarge.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.onSurface,
      ),
    );
  }

  Widget _buildSessionListContent() {
    if (state is GetAllBookedSessionsByStatusLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.xxl),
        child: LoadingView.compact(),
      );
    }

    if (state is GetAllBookedSessionsByStatusError) {
      return ErrorView(
        message: 'Failed to fetch sessions',
        onRetry: () {
          final doctorId = cubit.myDoctorList?[cubit.current].id;
          if (doctorId != null) {
            cubit.GetAllCommingSessionsBookedaSpecificParent(
                doctorId, selectedTabIndex == 1);
          }
        },
      );
    }

    // Success / Empty state
    if (cubit.sessions.isEmpty) {
      return EmptyView(
        message: selectedTabIndex == 0
            ? 'No completed sessions found.'
            : 'No upcoming sessions scheduled.',
        icon: Icons.calendar_today_outlined,
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cubit.sessions.length,
      itemBuilder: (context, index) =>
          SessionCard(session: cubit.sessions[index]),
    );
  }

  Widget _buildProgressOverview(BuildContext context) {
    if (state is GetAutisumLevelTestHistoryLoading) {
      return const AppCard(child: LoadingView.compact());
    }

    // Extract latest degree from history
    final history = cubit.autismLevelHistory?.data;
    if (history != null && history.isNotEmpty) {
      // Find latest test by creation date
      final latestTest = history.first;
      final degree = latestTest.output?.degreePrediction ?? 0;

      // Calculate progress and label based on degree (Degree is usually 1, 2, or 3)
      final double progress = degree / 3.0;
      final String label = 'L$degree';

      return ProgressOverviewCard(
        progress: progress,
        label: label,
      );
    }

    // No tests taken yet or error fetching history (silent fallback to CTA)
    return ProgressOverviewCard(
      progress: null,
      label: null,
      onTakeTest: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TestSelectionScreen()),
        );
      },
    );
  }
}
