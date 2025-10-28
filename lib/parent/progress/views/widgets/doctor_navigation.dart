import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

/// A selector for navigating between booked doctors.
class DoctorNavigation extends StatelessWidget {
  final String doctorName;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool hasPrevious;
  final bool hasNext;

  const DoctorNavigation({
    super.key,
    required this.doctorName,
    required this.onPrevious,
    required this.onNext,
    this.hasPrevious = true,
    this.hasNext = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppIconButton(
          icon: Icons.arrow_back_ios_new,
          onPressed: hasPrevious ? onPrevious : null,
          iconColor: hasPrevious ? AppColors.primary : AppColors.textDisabled,
        ),
        Expanded(
          child: Text(
            doctorName,
            style: AppTypography.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        AppIconButton(
          icon: Icons.arrow_forward_ios,
          onPressed: hasNext ? onNext : null,
          iconColor: hasNext ? AppColors.primary : AppColors.textDisabled,
        ),
      ],
    );
  }
}
