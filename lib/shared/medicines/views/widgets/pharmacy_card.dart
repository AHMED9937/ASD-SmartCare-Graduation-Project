import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/medicines/models/medicine_model.dart';
import 'package:flutter/material.dart';

class PharmacyCard extends StatelessWidget {
  final Pharmacy pharmacy;

  const PharmacyCard({super.key, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: AppColors.primary,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: const Icon(
              Icons.local_pharmacy_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const AppSpacer.md(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pharmacy.name,
                  style: AppTypography.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const AppSpacer.xs(),
                Text(
                  pharmacy.location,
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          if (pharmacy.phone.isNotEmpty)
            AppIconButton(
              icon: Icons.phone_in_talk_rounded,
              iconColor: Colors.white,
              onPressed: () {
                // In a real app, this would trigger a call
              },
            ),
        ],
      ),
    );
  }
}
