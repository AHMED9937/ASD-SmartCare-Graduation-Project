import 'package:asdsmartcare/shared/donations/models/charity_model.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

/// Redesigned Charity Medicine Details screen with immersive interactions.
class Charitiymedicaninfo extends StatelessWidget {
  final CharityMedicine medicen;
  const Charitiymedicaninfo({super.key, required this.medicen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // 1. Hero Image Header
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: const _CircularBackButton(),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'charity_med_${medicen.id}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (medicen.medicanImage != null &&
                        medicen.medicanImage!.isNotEmpty)
                      Image.network(medicen.medicanImage!, fit: BoxFit.cover)
                    else
                      Container(
                          color: AppColors.primary.withValues(alpha: 0.2)),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black38,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. Content Section
          SliverToBoxAdapter(
            child: Container(
              transform: Matrix4.translationValues(0, -24, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.xl),
                  topRight: Radius.circular(AppRadius.xl),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge
                    _buildCategoryBadge(),
                    const AppSpacer.sm(),

                    // Title
                    Text(
                      medicen.medicanName ?? 'Unknown Medicine',
                      style: AppTypography.displaySmall.copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const AppSpacer.lg(),

                    // Description
                    const _SectionTitle(title: 'Description'),
                    const AppSpacer.sm(),
                    Text(
                      medicen.medicanInfo ?? 'No description available.',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.onSurface.withValues(alpha: 0.8),
                        height: 1.6,
                      ),
                    ),
                    const AppSpacer.xl(),

                    const AppDivider(),
                    const AppSpacer.xl(),

                    // Pharmacy Section
                    const _SectionTitle(title: 'Available At'),
                    const AppSpacer.md(),
                    _buildPharmacyCard(),

                    const AppSpacer.xxl(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: const Text(
        'CHARITY DONATION',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: AppColors.success,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildPharmacyCard() {
    final pharmacy = medicen.pharmacy;
    if (pharmacy == null) return const SizedBox.shrink();

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
                  pharmacy.pName ?? 'Unknown Pharmacy',
                  style: AppTypography.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const AppSpacer.xs(),
                Text(
                  pharmacy.pLocation ?? 'No location',
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.titleMedium.copyWith(
        color: AppColors.primaryDark,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _CircularBackButton extends StatelessWidget {
  const _CircularBackButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.white.withValues(alpha: 0.9),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
