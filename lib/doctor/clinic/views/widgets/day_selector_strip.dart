import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

class DaySelectorStrip extends StatelessWidget {
  final List<String> weekDays;
  final String selectedDay;
  final ValueChanged<String> onDaySelected;
  final Map<String, bool> activeDays;

  const DaySelectorStrip({
    super.key,
    required this.weekDays,
    required this.selectedDay,
    required this.onDaySelected,
    required this.activeDays,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: weekDays.map((day) {
          final isSelected = selectedDay == day;
          final isActive = activeDays[day] ?? false;

          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: Semantics(
              label: 'Select $day',
              selected: isSelected,
              button: true,
              child: FilterPill(
                label: day,
                isSelected: isSelected,
                onTap: () => onDaySelected(day),
                icon: isActive ? Icons.check_circle : null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
