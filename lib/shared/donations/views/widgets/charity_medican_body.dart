import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/donations/models/charity_model.dart';
import 'package:asdsmartcare/shared/donations/views/widgets/charity_medicine_card.dart';
import 'package:flutter/material.dart';

class CharityMedicanBody extends StatefulWidget {
  final List<CharityMedicine> medicines;

  const CharityMedicanBody({super.key, required this.medicines});

  @override
  State<CharityMedicanBody> createState() => _CharityMedicanBodyState();
}

class _CharityMedicanBodyState extends State<CharityMedicanBody> {
  late List<CharityMedicine> displayed;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayed = List.from(widget.medicines);
  }

  void _filter(String query) {
    setState(() {
      displayed = widget.medicines
          .where((med) => (med.medicanName ?? '')
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Header
        _buildHeader(),

        // Content
        Expanded(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.transparent,
      ),
      child: Column(
        children: [
          Text(
            'Explore available medicines from this charity',
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
          const AppSpacer.md(),
          AppSearchField(
            controller: _searchController,
            hint: 'Search medicines...',
            onChanged: _filter,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (displayed.isEmpty) {
      return const EmptyView(
        message: 'No medicines match your search.',
        icon: Icons.volunteer_activism_outlined,
      );
    }

    return ResponsivePadding(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        itemCount: displayed.length,
        separatorBuilder: (_, __) => const AppSpacer.md(),
        itemBuilder: (context, index) {
          return CharityMedicineCard(medicine: displayed[index]);
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
