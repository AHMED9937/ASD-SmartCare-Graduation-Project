import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:asdsmartcare/presentation/DoctorLayout/Home/appointments/cubit/appointments_cubit.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/Home/appointments/cubit/appointments_state.dart';

/// Model representing an appointment
class Appointment {
  final String id;
  final String doctorId;
  final DateTime date;
  final String day;
  final String time;
  String status; // mutable for filtering

  Appointment({
    required this.id,
    required this.doctorId,
    required this.date,
    required this.day,
    required this.time,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'] as String,
      doctorId: json['doctorId'] as String,
      date: DateTime.parse(json['date'] as String),
      day: (json['day'] as String).capitalize(),
      time: json['time'] as String,
      status: (json['status'] as String).capitalize(),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() => isNotEmpty
      ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
      : '';
}

/// Screen to display and filter a list of appointments
class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({Key? key}) : super(key: key);

  @override
  _AppointmentListScreenState createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  String _filterStatus = 'All';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => DoctorAppointmentListCubit()..fetchAppointments(status: _filterStatus.toLowerCase()),
      child: BlocConsumer<DoctorAppointmentListCubit, GetDoctorAppointmentListStates>(
        listener: (_, __) {},
        builder: (context, state) {
          final cubit = DoctorAppointmentListCubit.get(context);
          // Parse raw JSON items into Appointment model
          final rawJson = cubit.Appointments?.appointment ?? [];
          final raw = rawJson.map((j) => Appointment.fromJson(j.toJson())).toList();

          // Available status filters
          final statuses = ['All', 'Booked', 'Cancelled'];
          // Filtered list
          final filtered = _filterStatus == 'All'
              ? raw
              : raw.where((a) => a.status == _filterStatus).toList();

          // Group appointments by formatted date
          final grouped = <String, List<Appointment>>{};
          for (var appt in filtered) {
            final key = DateFormat('EEEE, MMM d, yyyy').format(appt.date);
            grouped.putIfAbsent(key, () => []).add(appt);
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar:AppBarWithText(context, "Appointments"),
            body: Column(
              children: [
                // Status filter dropdown
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Text('Show: '),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _filterStatus,
                        items: statuses
                            .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        onChanged: (value) => setState(() {
                          if (value != null) _filterStatus = value;
                        }),
                      ),
                    ],
                  ),
                ),
                // Appointment list grouped by date
             Expanded(
  child: state is GetDoctorAppointmentListLoadingStates
      ? const Center(child: CircularProgressIndicator())
      : filtered.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.event_busy, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No appointments found',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              children: grouped.entries
                  .map((entry) => _DateSection(
                        dateLabel: entry.key,
                        items: entry.value,
                      ))
                  .toList(),
            ),
),

             
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DateSection extends StatelessWidget {
  final String dateLabel;
  final List<Appointment> items;

  const _DateSection({Key? key, required this.dateLabel, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              dateLabel,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
          ),
          ...items.map((appt) => _AppointmentCard(appointment: appt)).toList(),
        ],
      );
}

class _AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const _AppointmentCard({Key? key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine status color
    final statusLower = appointment.status.toLowerCase();
    final statusColor = statusLower == 'booked'
        ? Colors.green
        : statusLower == 'cancelled'
            ? Colors.red
            : Colors.blue;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.1),
          child: Icon(Icons.calendar_today, color: statusColor),
        ),
        title: Text(appointment.time, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('${appointment.day}, ${DateFormat('MMM d').format(appointment.date)}'),
        trailing: Chip(
          label: Text(appointment.status, style: const TextStyle(color: Colors.white)),
          backgroundColor: statusColor,
        ),
      ),
    );
  }
}
