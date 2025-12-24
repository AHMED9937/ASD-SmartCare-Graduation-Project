import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/donations/models/charity_model.dart';
import 'package:asdsmartcare/shared/donations/views/charity_details_screen.dart';
import 'package:flutter/material.dart';

class CharityMedicineCard extends StatelessWidget {
  final CharityMedicine medicine;

  const CharityMedicineCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => _navigateToDetails(context),
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.medicanName ?? 'Unknown Medicine',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const AppSpacer.xs(),
                    if (medicine.pharmacy != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              medicine.pharmacy?.pLocation ?? 'No location',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    const Spacer(),
                    const AppSpacer.sm(),
                    AppButton(
                      label: 'View Details',
                      onPressed: () => _navigateToDetails(context),
                      size: AppButtonSize.small,
                      style: AppButtonStyle.secondary,
                      expanded: false,
                    ),
                  ],
                ),
              ),
            ),

            // Right Visual (Image)
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.05),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(AppRadius.md),
                  bottomRight: Radius.circular(AppRadius.md),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(AppRadius.md),
                  bottomRight: Radius.circular(AppRadius.md),
                ),
                child: (medicine.medicanImage != null &&
                        medicine.medicanImage!.isNotEmpty)
                    ? Image.network(
                        medicine.medicanImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildPlaceholder(),
                      )
                    : _buildPlaceholder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return const Center(
      child: Icon(
        Icons.medical_services_outlined,
        color: AppColors.primary,
        size: 32,
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Charitiymedicaninfo(medicen: medicine),
      ),
    );
  }
}
