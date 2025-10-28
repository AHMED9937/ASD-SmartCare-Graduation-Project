import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_cubit.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_state.dart';
import 'widgets/child_progress_body.dart';

/// Redesigned Parent Progress screen following SOLID principles.
/// High-level orchestration of BlocProvider and UI states.
class ChildProgressScreen extends StatefulWidget {
  final ChildProgressCubit? cubit;
  const ChildProgressScreen({super.key, this.cubit});

  @override
  State<ChildProgressScreen> createState() => _ChildProgressScreenState();
}

class _ChildProgressScreenState extends State<ChildProgressScreen> {
  late ChildProgressCubit _cubit;
  int _selectedTabIndex = 0; // 0 for Done, 1 for Upcoming

  @override
  void initState() {
    super.initState();
    _cubit = widget.cubit ?? ChildProgressCubit();
    // Only fetch if we're not already loading or loaded (prevents double-fetch if cubit is reused)
    _cubit.InitialFetchUnifiedData(_selectedTabIndex == 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: const AppHeader(
          showBackButton: false, // Bottom navigation tab - never show back
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(
              title: 'Child Progress',
              subtitle: 'Track your child\'s development and sessions',
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: BlocConsumer<ChildProgressCubit, ChildProgressState>(
                listener: (context, state) {},
                builder: (context, state) {
                  final cubit = ChildProgressCubit.get(context);

                  return ChildProgressBody(
                    cubit: cubit,
                    state: state,
                    selectedTabIndex: _selectedTabIndex,
                    onTabChanged: (index) {
                      setState(() => _selectedTabIndex = index);
                      _fetchSessionsForCurrentDoctor(context);
                    },
                    onNextDoctor: () {
                      if (cubit.current <
                          (cubit.myDoctorList?.length ?? 0) - 1) {
                        cubit.current++;
                        _fetchSessionsForCurrentDoctor(context);
                      }
                    },
                    onPreviousDoctor: () {
                      if (cubit.current > 0) {
                        cubit.current--;
                        _fetchSessionsForCurrentDoctor(context);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchSessionsForCurrentDoctor(BuildContext context) {
    final cubit = ChildProgressCubit.get(context);
    final doctors = cubit.myDoctorList;
    if (doctors != null && doctors.isNotEmpty) {
      final currentDoctorId = doctors[cubit.current].id ?? '';
      cubit.GetAllCommingSessionsBookedaSpecificParent(
        currentDoctorId,
        _selectedTabIndex == 1,
      );
    }
  }
}
