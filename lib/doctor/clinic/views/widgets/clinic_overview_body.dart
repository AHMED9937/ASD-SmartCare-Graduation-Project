import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/clinic/views/widgets/day_availability_card.dart';
import 'package:asdsmartcare/doctor/clinic/views/widgets/day_selector_strip.dart';
import 'package:flutter/material.dart';

class ClinicOverviewBody extends StatefulWidget {
  final Map<String, bool> availableDays;
  final Map<String, DateTime?> selectedDates;
  final Map<String, List<TimeOfDay>> selectedTimes;
  final List<String> weekDays;
  final Function(String) onPickDate;
  final Function(String) onPickTime;
  final Function(String, int) onDeleteTime;
  final Function(String, bool) onToggleDay;
  final VoidCallback onSave;

  const ClinicOverviewBody({
    super.key,
    required this.availableDays,
    required this.selectedDates,
    required this.selectedTimes,
    required this.weekDays,
    required this.onPickDate,
    required this.onPickTime,
    required this.onDeleteTime,
    required this.onToggleDay,
    required this.onSave,
  });

  @override
  State<ClinicOverviewBody> createState() => _ClinicOverviewBodyState();
}

class _ClinicOverviewBodyState extends State<ClinicOverviewBody> {
  late String _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.weekDays.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DaySelectorStrip(
          weekDays: widget.weekDays,
          selectedDay: _selectedDay,
          onDaySelected: (day) => setState(() => _selectedDay = day),
          activeDays: widget.availableDays,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
            child: Column(
              children: [
                DayAvailabilityCard(
                  day: _selectedDay,
                  isActive: widget.availableDays[_selectedDay] ?? false,
                  selectedDate: widget.selectedDates[_selectedDay],
                  selectedTimes: widget.selectedTimes[_selectedDay] ?? [],
                  onToggleActive: () => widget.onToggleDay(_selectedDay,
                      !(widget.availableDays[_selectedDay] ?? false)),
                  onPickDate: () => widget.onPickDate(_selectedDay),
                  onAddTime: () => widget.onPickTime(_selectedDay),
                  onDeleteTime: (index) =>
                      widget.onDeleteTime(_selectedDay, index),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: AppButton(
              label: 'Save All Changes',
              onPressed: widget.onSave,
              icon: Icons.save_outlined,
            ),
          ),
        ),
      ],
    );
  }
}
