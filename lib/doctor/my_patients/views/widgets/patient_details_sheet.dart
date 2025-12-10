import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/my_patients/models/patient_model.dart';
import 'package:asdsmartcare/doctor/my_patients/views/widgets/session_form.dart';

class PatientDetailsSheet extends StatelessWidget {
  final Parents parent;
  final Childs child;
  final ScrollController scrollController;

  const PatientDetailsSheet({
    super.key,
    required this.parent,
    required this.child,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.bottomSheet,
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            _buildHandle(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                children: [_buildInfoTab(), _buildSessionTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.textDisabled.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return const TabBar(
      indicatorColor: AppColors.primary,
      indicatorWeight: 3,
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.textSecondary,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      tabs: [
        Tab(text: 'Info'),
        Tab(text: 'Create Session'),
      ],
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.background,
              child: Icon(
                Icons.person_rounded,
                size: 50,
                color: AppColors.textDisabled,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _DetailItem(label: 'Parent Name', value: parent.userName ?? '-'),
          const SizedBox(height: AppSpacing.md),
          _DetailItem(label: 'Child Name', value: child.childName ?? '-'),
          const SizedBox(height: AppSpacing.md),
          _DetailItem(label: 'Child Age', value: child.age ?? '-'),
          const SizedBox(height: AppSpacing.md),
          _DetailItem(label: 'Child Gender', value: child.gender ?? '-'),
        ],
      ),
    );
  }

  Widget _buildSessionTab() {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: SessionForm(parentId: parent.id ?? ''),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;

  const _DetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.mdRadius,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
