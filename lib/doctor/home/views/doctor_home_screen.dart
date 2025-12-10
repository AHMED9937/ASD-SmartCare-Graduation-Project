import 'package:asdsmartcare/doctor/my_patients/views/patients_screen.dart';
import 'package:asdsmartcare/doctor/appointments/views/appointments_screen.dart';
import 'package:asdsmartcare/doctor/sessions/list/views/sessions_screen.dart';
import 'package:asdsmartcare/doctor/home/views/widgets/quick_action_card.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: DoctorHomeBody(),
    );
  }
}

class DoctorHomeBody extends StatelessWidget {
  const DoctorHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final items = _getItems(context);

    return ResponsiveContainer.builder(
      builder: (context, breakpoint) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageHeader(
                    title: 'Welcome Back,',
                    subtitle: 'Manage your daily operations',
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Text(
                      'Quick Actions',
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildActionsGrid(context, items, breakpoint),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionsGrid(
    BuildContext context,
    List<Map<String, Object>> items,
    DeviceBreakpoint breakpoint,
  ) {
    final crossAxisCount = breakpoint == DeviceBreakpoint.mobile
        ? 1
        : (breakpoint == DeviceBreakpoint.tablet ? 2 : 3);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        mainAxisExtent: 220, // Substantial height for cards
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return QuickActionCard(
          icon: item['icon'] as IconData,
          title: item['title'] as String,
          subtitle: item['subtitle'] as String,
          onTap: item['onTap'] as VoidCallback,
        );
      },
    );
  }

  List<Map<String, Object>> _getItems(BuildContext context) {
    return [
      {
        'icon': Icons.notifications_active_outlined,
        'title': 'Upcoming Sessions',
        'subtitle': 'Manage today and tomorrow\'s schedule',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SessionsScreen(status: 'coming'),
          ),
        ),
      },
      {
        'icon': Icons.task_alt_rounded,
        'title': 'Completed Sessions',
        'subtitle': 'Review past sessions and progress',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SessionsScreen(status: 'done'),
          ),
        ),
      },
      {
        'icon': Icons.person_add_alt_1_outlined,
        'title': 'New Session',
        'subtitle': 'Create a session for a registered child',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RegisteredChildrenScreen()),
        ),
      },
      {
        'icon': Icons.event_note_rounded,
        'title': 'Appointment List',
        'subtitle': 'View and manage all appointments',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AppointmentListScreen()),
        ),
      },
    ];
  }
}
