import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:asdsmartcare/doctor/appointments/controllers/appointments_cubit.dart';
import 'package:asdsmartcare/doctor/appointments/controllers/appointments_state.dart';
import 'package:asdsmartcare/doctor/appointments/views/widgets/appointment_item_card.dart';
import 'package:asdsmartcare/doctor/appointments/views/widgets/status_filter_row.dart';

/// Screen to display and filter a list of appointments for doctors.
class AppointmentListScreen extends StatelessWidget {
  final DoctorAppointmentListCubit? cubit;
  const AppointmentListScreen({super.key, this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          cubit ??
          (DoctorAppointmentListCubit()..fetchAppointments(status: 'all')),
      child: const Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: AppointmentsOverviewBody(),
      ),
    );
  }
}

class AppointmentsOverviewBody extends StatefulWidget {
  const AppointmentsOverviewBody({super.key});

  @override
  State<AppointmentsOverviewBody> createState() =>
      _AppointmentsOverviewBodyState();
}

class _AppointmentsOverviewBodyState extends State<AppointmentsOverviewBody> {
  String _selectedStatus = 'All';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorAppointmentListCubit,
        GetDoctorAppointmentListStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = DoctorAppointmentListCubit.get(context);

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(showBackButton: false),
              const PageHeader(
                title: 'Appointments',
                subtitle: 'Manage your upcoming and past sessions.',
              ),
              StatusFilterRow(
                selectedStatus: _selectedStatus,
                onStatusChanged: (status) {
                  setState(() => _selectedStatus = status);
                  cubit.fetchAppointments(status: status.toLowerCase());
                },
              ),
              Expanded(
                child: ResponsiveContainer(
                  mobile: _buildStateContent(context, state),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStateContent(
      BuildContext context, GetDoctorAppointmentListStates state) {
    if (state is GetDoctorAppointmentListLoadingStates) {
      return const LoadingView();
    }

    if (state is GetDoctorAppointmentListFailedStates) {
      return ErrorView(
        message: 'Failed to load appointments',
        onRetry: () => DoctorAppointmentListCubit.get(context)
            .fetchAppointments(status: _selectedStatus.toLowerCase()),
      );
    }

    final cubit = DoctorAppointmentListCubit.get(context);
    final appointments = cubit.appointments?.appointment ?? [];

    if (appointments.isEmpty) {
      return const EmptyView(
        title: 'No Appointments',
        message: 'You don\'t have any appointments scheduled for this filter.',
        icon: Icons.event_busy,
      );
    }

    // Grouping logic (simplified)
    final grouped = <String, List<dynamic>>{};
    for (final appt in appointments) {
      final date =
          DateTime.parse(appt.date ?? DateTime.now().toIso8601String());
      final key = DateFormat('EEEE, MMM d, yyyy').format(date);
      grouped.putIfAbsent(key, () => []).add(appt);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: grouped.length,
      itemBuilder: (context, index) {
        final entry = grouped.entries.elementAt(index);
        return AppointmentDateSection(
          dateLabel: entry.key,
          appointments: entry.value,
        );
      },
    );
  }
}

class AppointmentDateSection extends StatelessWidget {
  final String dateLabel;
  final List<dynamic> appointments;

  const AppointmentDateSection({
    super.key,
    required this.dateLabel,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Text(
            dateLabel,
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        ...appointments.map((appt) => AppointmentItemCard(appointment: appt)),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}
