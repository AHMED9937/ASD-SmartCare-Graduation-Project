import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/account/controllers/doctor_profile_cubit.dart';
import 'package:asdsmartcare/doctor/account/controllers/doctor_profile_state.dart';
import 'package:asdsmartcare/doctor/account/views/edit_profile_screen.dart';
import 'package:asdsmartcare/doctor/sessions/manage/views/pdf_viewer_screen.dart';
import 'package:asdsmartcare/parent/account/views/change_password_screen.dart';
import 'package:flutter/material.dart';

/// Doctor profile body widget following SOLID composition.
/// Displays doctor information, stats, and action buttons.
class DoctorProfileBody extends StatelessWidget {
  final GetDoctorDataCubit cubit;
  final GetDoctorDataStates state;

  const DoctorProfileBody({
    super.key,
    required this.cubit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final doctor = cubit.Cur_Doctor?.data;
    if (doctor == null) return const SizedBox.shrink();

    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _ImmersiveHeader(doctor: doctor),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                const TabBar(
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.primary,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(text: 'Professional'),
                    Tab(text: 'Account'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            _ProfessionalTab(doctor: doctor),
            _AccountTab(doctor: doctor, cubit: cubit),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.scaffoldBackground.withValues(alpha: 0.8),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

/// Immersive header with gradient, avatar, and doctor info.
class _ImmersiveHeader extends StatelessWidget {
  final dynamic doctor;

  const _ImmersiveHeader({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      collapsedHeight: 80,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppSpacer.xl(),
            Semantics(
              label: 'Doctor profile photo',
              child: ProfileAvatar(
                imageUrl: doctor.image,
                radius: 54,
              ),
            ),
            const AppSpacer.md(),
            Text(
              doctor.parent?.userName ?? '',
              style: AppTypography.headlineMedium.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.bold,
              ),
              semanticsLabel:
                  'Doctor name: ${doctor.parent?.userName ?? 'Unknown'}',
            ),
            Text(
              doctor.speciailization ?? 'Specialist',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 1.2,
              ),
            ),
            const AppSpacer.xs(),
            Semantics(
              label: 'Rating: ${doctor.ratingsAverage ?? 0} out of 5 stars',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star_rounded,
                    size: 20,
                    color: index < (doctor.ratingsAverage ?? 0)
                        ? AppColors.warning
                        : AppColors.textDisabled.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tab for professional details.
class _ProfessionalTab extends StatelessWidget {
  final dynamic doctor;

  const _ProfessionalTab({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StatsBar(doctor: doctor),
          const AppSpacer.xl(),
          const SectionHeader(title: 'Overview'),
          const AppSpacer.sm(),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              doctor.qualifications ?? 'No qualifications provided yet.',
              style: AppTypography.bodyMedium,
            ),
          ),
          const AppSpacer.xl(),
          const SectionHeader(title: 'Medical License'),
          const AppSpacer.sm(),
          AppCard(
            padding: EdgeInsets.zero,
            child: ProfileDetailTile(
              icon: Icons.description_outlined,
              label: 'Verification Status',
              value: 'Tap to view credential',
              onTap: () {
                if (doctor.medicalLicense != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FileFetchAndOpenScreen(
                          rawUrl: doctor.medicalLicense!),
                    ),
                  );
                }
              },
            ),
          ),
          const AppSpacer.xxl(),
        ],
      ),
    );
  }
}

/// Tab for account details and actions.
class _AccountTab extends StatelessWidget {
  final dynamic doctor;
  final GetDoctorDataCubit cubit;

  const _AccountTab({required this.doctor, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Personal Info'),
          const AppSpacer.sm(),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ProfileDetailTile(
                  icon: Icons.cake_outlined,
                  label: 'Age',
                  value: '${doctor.parent?.age ?? 'N/A'} Years',
                ),
                const AppDivider(indent: 52),
                ProfileDetailTile(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: doctor.parent?.email ?? 'Not provided',
                ),
              ],
            ),
          ),
          const AppSpacer.xl(),
          const SectionHeader(title: 'Account Actions'),
          const AppSpacer.md(),
          _ActionButtons(cubit: cubit),
          const AppSpacer.xxl(),
        ],
      ),
    );
  }
}

/// Stats bar showing experience, price, and rating.
class _StatsBar extends StatelessWidget {
  final dynamic doctor;

  const _StatsBar({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const StatItem(
              label: 'Experience',
              value: '5+ Yrs',
              icon: Icons.history_edu_rounded,
            ),
            const VerticalDivider(width: 1),
            StatItem(
              label: 'Price',
              value: '${doctor.sessionPrice} \$',
              icon: Icons.payments_outlined,
            ),
            const VerticalDivider(width: 1),
            StatItem(
              label: 'Rating',
              value: '${doctor.ratingsAverage ?? 0}.0',
              icon: Icons.grade_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

/// Action buttons for edit, change password, and logout.
class _ActionButtons extends StatelessWidget {
  final GetDoctorDataCubit cubit;

  const _ActionButtons({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Semantics(
          button: true,
          label: 'Edit your profile',
          child: AppButton(
            label: 'Edit Profile',
            icon: Icons.edit_rounded,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditDoctorProfileScreen(
                    DoctorD: cubit.Cur_Doctor!,
                  ),
                ),
              ).then((_) => cubit.getDoctorData());
            },
          ),
        ),
        const AppSpacer.md(),
        Semantics(
          button: true,
          label: 'Change your password',
          child: AppButton.secondary(
            label: 'Change Password',
            icon: Icons.lock_outline_rounded,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChangePasswordScreen(isParent: false),
                ),
              );
            },
          ),
        ),
        const AppSpacer.xl(),
        const AppDivider(),
        const AppSpacer.xl(),
        Semantics(
          button: true,
          label: 'Log out of your account',
          child: AppButton.text(
            label: 'Log Out',
            textColor: AppColors.error,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ),
      ],
    );
  }
}
