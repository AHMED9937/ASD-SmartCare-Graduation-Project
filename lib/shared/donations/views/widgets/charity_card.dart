import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/donations/models/charity_model.dart';
import 'package:asdsmartcare/shared/donations/views/charity_info_screen.dart';
import 'package:flutter/material.dart';

class CharityCard extends StatelessWidget {
  final Charity charity;

  const CharityCard({super.key, required this.charity});

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
                      charity.charityName ?? 'Unknown Charity',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const AppSpacer.xs(),
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
                            charity.charityAddress ?? 'No address provided',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const AppSpacer.sm(),
                    if (charity.charityMedican != null &&
                        charity.charityMedican!.isNotEmpty)
                      _buildMedicineChips(),
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

            // Right Visual (Logo)
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
                child: (charity.logo != null && charity.logo!.isNotEmpty)
                    ? Image.network(
                        charity.logo!,
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

  Widget _buildMedicineChips() {
    final medNames = charity.charityMedican!
        .take(2)
        .map((m) => m.medicanName ?? '')
        .where((n) => n.isNotEmpty)
        .toList();

    if (medNames.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: AppSpacing.xs,
      children: [
        ...medNames.map((name) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: Text(
                name,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.success,
                  fontSize: 10,
                ),
              ),
            )),
        if (charity.charityMedican!.length > 2)
          Text(
            '+${charity.charityMedican!.length - 2} more',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return const Center(
      child: Icon(
        Icons.volunteer_activism_outlined,
        color: AppColors.primary,
        size: 32,
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharityInfo(charityData: charity),
      ),
    );
  }
}
