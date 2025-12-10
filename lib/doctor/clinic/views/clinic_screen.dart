import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/clinic/controllers/clinic_cubit.dart';
import 'package:asdsmartcare/doctor/clinic/controllers/clinic_state.dart';
import 'package:asdsmartcare/doctor/clinic/views/widgets/clinic_overview_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicDoctorScreen extends StatefulWidget {
  final AvailabilityCubit? cubit;
  const ClinicDoctorScreen({super.key, this.cubit});

  @override
  _ClinicDoctorScreenState createState() => _ClinicDoctorScreenState();
}

class _ClinicDoctorScreenState extends State<ClinicDoctorScreen> {
  final List<String> _weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final Map<String, bool> _availableDays = {};
  final Map<String, DateTime?> _selectedDates = {};
  final Map<String, List<TimeOfDay>> _selectedTimes = {};
  final List<Map<String, String>> _newSlots = [];

  @override
  void initState() {
    super.initState();
    for (final day in _weekDays) {
      _availableDays[day] = false;
      _selectedDates[day] = null;
      _selectedTimes[day] = <TimeOfDay>[];
    }
  }

  DateTime _nextDateForWeekday(int wd) {
    final now = DateTime.now();
    int diff = wd - now.weekday;
    if (diff <= 0) diff += 7;
    return now.add(Duration(days: diff));
  }

  int _weekdayFromName(String day) {
    const map = {
      'Monday': DateTime.monday,
      'Tuesday': DateTime.tuesday,
      'Wednesday': DateTime.wednesday,
      'Thursday': DateTime.thursday,
      'Friday': DateTime.friday,
      'Saturday': DateTime.saturday,
      'Sunday': DateTime.sunday,
    };
    return map[day]!;
  }

  Future<void> _pickDate(String day) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDates[day] ?? _nextDateForWeekday(_weekdayFromName(day)),
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
      selectableDayPredicate: (d) => d.weekday == _weekdayFromName(day),
      builder: (ctx, child) {
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.onPrimary,
              onSurface: AppColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) setState(() => _selectedDates[day] = picked);
  }

  Future<void> _pickTime(String day) async {
    if (_selectedDates[day] == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Select date first')));
      return;
    }
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (ctx, child) {
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onSurface: AppColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (t != null) {
      setState(() {
        _selectedTimes[day]!.add(t);
        final date = _selectedDates[day]!;
        _newSlots.add({
          'day': day.toLowerCase(),
          'date':
              '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
          'time': t.format(context),
        });
      });
    }
  }

  void _initializeServerAvailability(BuildContext ctx) {
    final cubit = AvailabilityCubit.get(ctx);
    final data = cubit.availabilityDays?.data ?? [];
    for (final day in _weekDays) {
      _availableDays[day] = false;
      _selectedDates[day] = null;
      _selectedTimes[day]!.clear();
    }
    for (final slot in data) {
      final capDay = slot.day![0].toUpperCase() + slot.day!.substring(1);
      _availableDays[capDay] = true;
      final parts = slot.date!.split('-');
      _selectedDates[capDay] = DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
      final tp = slot.time!.split(' ');
      final hm = tp[0].split(':');
      var hour = int.parse(hm[0]);
      final minute = int.parse(hm[1]);
      if (tp[1] == 'PM' && hour < 12) hour += 12;
      if (tp[1] == 'AM' && hour == 12) hour = 0;
      _selectedTimes[capDay]!.add(TimeOfDay(hour: hour, minute: minute));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          widget.cubit ?? (AvailabilityCubit()..getDocAvailability()),
      child: BlocConsumer<AvailabilityCubit, AvailabilityState>(
        listener: (context, state) {
          if (state is GetDoctorAvailabilitySuccess) {
            _initializeServerAvailability(context);
          }
          if (state is AvailabilitySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Availability updated successfully'),
              ),
            );
          }
          if (state is AvailabilityError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to update availability')),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackground,
            body: Column(
              children: [
                const PageHeader(
                  title: 'Clinic Availability',
                  subtitle:
                      'Manage your consultation slots and weekly schedule.',
                ),
                Expanded(
                  child: ResponsiveContainer(
                    mobile: _buildContent(context, state),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, AvailabilityState state) {
    if (state is GetDoctorAvailabilityLoading) {
      return const LoadingView();
    }

    if (state is GetDoctorAvailabilityError) {
      return ErrorView(
        message: 'Failed to load clinic settings',
        onRetry: () => AvailabilityCubit.get(context).getDocAvailability(),
      );
    }

    return ClinicOverviewBody(
      availableDays: _availableDays,
      selectedDates: _selectedDates,
      selectedTimes: _selectedTimes,
      weekDays: _weekDays,
      onPickDate: _pickDate,
      onPickTime: _pickTime,
      onToggleDay: (day, active) {
        setState(() {
          _availableDays[day] = active;
          if (active) {
            _selectedDates[day] = _nextDateForWeekday(_weekdayFromName(day));
          } else {
            _selectedDates[day] = null;
            _selectedTimes[day]!.clear();
            _newSlots.removeWhere((s) => s['day'] == day.toLowerCase());
          }
        });
      },
      onDeleteTime: (day, index) async {
        final cubit = AvailabilityCubit.get(context);
        final tod = _selectedTimes[day]![index].format(context);
        final date = _selectedDates[day]!;
        final dateStr =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

        final serverSlots = cubit.availabilityDays!.data!
            .where(
              (s) =>
                  s.day == day.toLowerCase() &&
                  s.time == tod &&
                  s.date == dateStr,
            )
            .toList();

        if (serverSlots.isNotEmpty) {
          await cubit.deleteAppointment(serverSlots.first.sId!);
        }

        setState(() {
          _selectedTimes[day]!.removeAt(index);
          _newSlots.removeWhere(
            (s) =>
                s['day'] == day.toLowerCase() &&
                s['date'] == dateStr &&
                s['time'] == tod,
          );
        });
      },
      onSave: () {
        if (_newSlots.isEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('No new slots to save')));
          return;
        }
        AvailabilityCubit.get(context).submitAvailability(_newSlots);
        _newSlots.clear();
      },
    );
  }
}
