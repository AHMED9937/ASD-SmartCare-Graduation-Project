// clinic_doctor_screen.dart
import 'package:asdsmartcare/presentation/Doctor/Clinic/cubit/clinic_cubit.dart';
import 'package:asdsmartcare/presentation/Doctor/Clinic/cubit/clinic_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ClinicDoctorScreen extends StatefulWidget {
  const ClinicDoctorScreen({Key? key}) : super(key: key);

  @override
  _ClinicDoctorScreenState createState() => _ClinicDoctorScreenState();
}

class _ClinicDoctorScreenState extends State<ClinicDoctorScreen> {
  final List<String> _weekDays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday', 'Sunday'
  ];
  final Map<String, bool> _availableDays = {};
  final Map<String, DateTime?> _selectedDates = {};
  final Map<String, List<TimeOfDay>> _selectedTimes = {};
  final List<Map<String, String>> _slots = [];

  @override
  void initState() {
    super.initState();
    for (var day in _weekDays) {
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
      initialDate: _selectedDates[day] ?? _nextDateForWeekday(_weekdayFromName(day)),
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
      selectableDayPredicate: (d) => d.weekday == _weekdayFromName(day),
    );
    if (picked != null) setState(() => _selectedDates[day] = picked);
  }

  Future<void> _pickTime(String day) async {
    if (_selectedDates[day] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select date first')),
      );
      return;
    }
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (t != null) setState(() => _selectedTimes[day]!.add(t));
  }

  void _initializeServerAvailability(BuildContext ctx) {
    final cubit = AvailabilityCubit.get(ctx);
    final data = cubit.availabilityDays?.data ?? [];
    _slots.clear();

    for (var day in _weekDays) {
      _availableDays[day] = false;
      _selectedDates[day] = null;
      _selectedTimes[day] = <TimeOfDay>[];
    }

    for (var slot in data) {
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

      _slots.add({
        'day': slot.day!,
        'date': slot.date!,
        'time': slot.time!,
      });
    }

    setState(() {});
  }

  void _updateAvailability(BuildContext ctx) {
    final cubit = AvailabilityCubit.get(ctx);
    _slots.clear();

    for (var day in _weekDays) {
      if (!_availableDays[day]!) continue;
      final date = _selectedDates[day]!;
      for (var tod in _selectedTimes[day]!) {
        _slots.add({
          'day': day.toLowerCase(),
          'date':
              '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
          'time': tod.format(ctx),
        });
      }
    }

    cubit.submitAvailability(_slots);
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF133E87);
    const accent = Color(0xFFCCDFFF);

    return BlocProvider(
      create: (_) => AvailabilityCubit()..GetDocAvailability(),
      child: BlocConsumer<AvailabilityCubit, AvailabilityState>(
        listener: (context, state) {
          if (state is GetDoctorAvailabilitySuccess) {
            _initializeServerAvailability(context);
          }
          if (state is AvailabilitySuccess) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Availability Submitted'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _slots.map((e) => ListTile(
                        title: Text(
                          '${e['day']} - ${e['date']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(e['time']!),
                      )).toList(),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Doctor Availability'),
              backgroundColor: primary,
            ),
            body: ConditionalBuilder(
              condition: state is! GetDoctorAvailabilityLoading,
              fallback: (_) => const Center(child: CircularProgressIndicator()),
              builder: (_) => Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _weekDays.length,
                      itemBuilder: (context, i) {
                        final day = _weekDays[i];
                        final on = _availableDays[day]!;
                        final date = _selectedDates[day];
                        final times = _selectedTimes[day]!;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border(
                              left: BorderSide(
                                color: on ? accent : Colors.white,
                                width: 5,
                              ),
                            ),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
                          ),
                          child: ExpansionTile(
                            title: Text(
                              day,
                              style: TextStyle(
                                color: on ? primary : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: Switch(
                              value: on,
                              activeColor: accent,
                              activeTrackColor: primary.withOpacity(0.6),
                              onChanged: (v) {
                                setState(() {
                                  _availableDays[day] = v;
                                  if (v) {
                                    _selectedDates[day] = _nextDateForWeekday(
                                        _weekdayFromName(day));
                                  } else {
                                    _selectedDates[day] = null;
                                    _selectedTimes[day]!.clear();
                                  }
                                });
                              },
                            ),
                            children: [
                              ListTile(
                                leading: Icon(Icons.date_range, color: primary),
                                title: Text(
                                  date != null
                                      ? 'Date: ${date.year}/${date.month}/${date.day}'
                                      : 'Select date',
                                ),
                                onTap: () => _pickDate(day),
                              ),
                              const Divider(),
                              for (var j = 0; j < times.length; j++)
                                ListTile(
                                  leading: Icon(Icons.access_time, color: primary),
                                  title: Text(times[j].format(context)),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => setState(() {
                                      _selectedTimes[day]!.removeAt(j);
                                    }),
                                  ),
                                ),
                              ListTile(
                                leading: Icon(Icons.add, color: primary),
                                title: const Text('Add time'),
                                onTap: () => _pickTime(day),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () => _updateAvailability(context),
                        child: const Text(
                          'Save Availability',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
