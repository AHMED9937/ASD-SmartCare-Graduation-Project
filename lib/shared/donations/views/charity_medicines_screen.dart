import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/donations/models/charity_model.dart';
import 'package:asdsmartcare/shared/donations/views/widgets/charity_medican_body.dart';
import 'package:flutter/material.dart';

/// Redesigned Charity Medicines screen following the SOLID thin-screen pattern.
class AvaillableCharityMed extends StatelessWidget {
  final List<CharityMedicine> medicines;

  const AvaillableCharityMed({super.key, required this.medicines});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Available Medicine',
            subtitle: 'Medicines provided by this charity',
          ),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    AppColors.primary.withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: CharityMedicanBody(medicines: medicines),
            ),
          ),
        ],
      ),
    );
  }
}
