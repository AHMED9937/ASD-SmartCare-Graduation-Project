import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/sessions/list/models/session_model.dart';
import 'package:asdsmartcare/doctor/sessions/manage/views/session_management_screen.dart';
import 'package:asdsmartcare/parent/find_doctors/details/views/doctor_reviews_screen.dart';

class SessionDetailsSheet extends StatelessWidget {
  final ParentData parent;
  final Child child;
  final Session session;
  final ScrollController scrollController;

  const SessionDetailsSheet({
    super.key,
    required this.parent,
    required this.child,
    required this.session,
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
        length: 3,
        child: Column(
          children: [
            _buildHandle(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  _buildInfoTab(),
                  _buildReviewsTab(),
                  _buildFeedbackTab(),
                ],
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
          color: AppColors.disabled.withValues(alpha: 0.5),
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
        Tab(text: 'Reviews'),
        Tab(text: 'Feedback'),
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
                color: AppColors.disabled,
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

  Widget _buildReviewsTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: ReviewListView(
        ID: session.id ?? '',
        showAllReviews: false,
      ),
    );
  }

  Widget _buildFeedbackTab() {
    return SessionManagement(sessionID: session.id ?? '');
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
        border: Border.all(color: AppColors.disabled.withValues(alpha: 0.1)),
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
