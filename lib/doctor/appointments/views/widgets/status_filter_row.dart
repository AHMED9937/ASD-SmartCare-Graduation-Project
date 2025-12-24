import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

class StatusFilterRow extends StatelessWidget {
  final String selectedStatus;
  final ValueChanged<String> onStatusChanged;

  const StatusFilterRow({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final statuses = ['All', 'Booked', 'Cancelled'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: statuses.map((status) {
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: FilterPill(
              label: status,
              isSelected: selectedStatus == status,
              onTap: () => onStatusChanged(status),
            ),
          );
        }).toList(),
      ),
    );
  }
}
