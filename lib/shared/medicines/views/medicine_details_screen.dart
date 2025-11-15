import 'package:asdsmartcare/shared/medicines/models/medicine_model.dart';
import 'package:asdsmartcare/shared/medicines/views/widgets/pharmacy_card.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

/// Redesigned Medicine Details screen with immersive interactions.
class MedicenInfo extends StatelessWidget {
  final MedicineData medicen;
  const MedicenInfo({super.key, required this.medicen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                tag: 'medicine_${medicen.id}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (medicen.medicanImage.isNotEmpty)
                      Image.network(medicen.medicanImage, fit: BoxFit.cover)
                    else
                      Container(
                          color: AppColors.primary.withValues(alpha: 0.2)),

                    // Subtle shadow overlay
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
                    // Badge/Category
                    _buildCategoryBadge(),
                    const AppSpacer.sm(),

                    // Medicine Title
                    Text(
                      medicen.medicanName,
                      style: AppTypography.displaySmall.copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const AppSpacer.lg(),

                    // Description Section
                    const _SectionTitle(title: 'Description'),
                    const AppSpacer.sm(),
                    Text(
                      medicen.medicanInfo,
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.onSurface.withValues(alpha: 0.8),
                        height: 1.6,
                      ),
                    ),
                    const AppSpacer.xl(),

                    const AppDivider(),
                    const AppSpacer.xl(),

                    // Availability Section
                    const _SectionTitle(title: 'Available At'),
                    const AppSpacer.md(),
                    PharmacyCard(pharmacy: medicen.pharmacy),

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
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: const Text(
        'PHARMACY TREATMENT',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
          letterSpacing: 1,
        ),
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
