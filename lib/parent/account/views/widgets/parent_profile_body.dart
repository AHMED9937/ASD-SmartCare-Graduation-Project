import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/account/controllers/parent_profile_cubit.dart';
import 'package:asdsmartcare/parent/account/controllers/parent_profile_state.dart';
import 'package:asdsmartcare/parent/account/views/edit_profile_screen.dart';
import 'package:asdsmartcare/parent/my_children/controllers/children_list_cubit.dart';
import 'package:asdsmartcare/parent/my_children/controllers/children_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentProfileBody extends StatelessWidget {
  final GetParentDataCubit cubit;
  final GetParentDataStates state;

  const ParentProfileBody({
    super.key,
    required this.cubit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final parent = cubit.Cur_Parent?.data;
    if (parent == null) return const SizedBox.shrink();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // ─── IMMERSIVE HEADER ──────────────────────────────────────────────
        SliverAppBar(
          expandedHeight: 240,
          collapsedHeight: 80,
          pinned: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primary,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.scaffoldBackground.withValues(alpha: 0.8),
                        AppColors.scaffoldBackground,
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppSpacing.xl),
                    ProfileAvatar(
                      imageUrl: parent.image,
                      radius: 54,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      parent.userName ?? '',
                      style: AppTypography.headlineMedium.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Guardian',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // ─── CONTENT ───────────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPaddingH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.lg),

                // --- Children Section ---
                const SectionHeader(
                  title: 'Your Children',
                ),
                const SizedBox(height: AppSpacing.sm),
                _buildChildrenSection(parent.id!),

                const SizedBox(height: AppSpacing.xl),

                // --- Details Section ---
                const SectionHeader(
                  title: 'Personal Details',
                ),
                const SizedBox(height: AppSpacing.sm),
                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ProfileDetailTile(
                        icon: Icons.cake_outlined,
                        label: 'Age',
                        value: '${parent.age} Years',
                      ),
                      const AppDivider(indent: 52),
                      ProfileDetailTile(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: parent.email ?? 'Not provided',
                      ),
                      const AppDivider(indent: 52),
                      ProfileDetailTile(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: parent.phone ?? 'Not provided',
                      ),
                      const AppDivider(indent: 52),
                      ProfileDetailTile(
                        icon: Icons.location_on_outlined,
                        label: 'Address',
                        value: parent.address ?? 'Not provided',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // --- Actions Section ---
                AppButton(
                  label: 'Edit Profile',
                  icon: Icons.edit_rounded,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditParentProfileScreen(
                          parentD: cubit.Cur_Parent!,
                        ),
                      ),
                    ).then((_) => cubit.getParentData());
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                AppButton.text(
                  label: 'Log Out',
                  textColor: AppColors.error,
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  },
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChildrenSection(String parentId) {
    return BlocProvider(
      create: (_) => ParentChildsListCubit()..getParentChildsList(parentId),
      child: BlocBuilder<ParentChildsListCubit, ParentChildsListStates>(
        builder: (context, state) {
          if (state is GetParentChildsListLoadingStates) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final children =
              ParentChildsListCubit.get(context).children?.childs ?? [];

          if (children.isEmpty) {
            return AppCard.outlined(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      const Icon(Icons.child_care_rounded,
                          color: AppColors.textDisabled, size: 40),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'No children added yet',
                        style: AppTypography.bodyMedium
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: children.map((child) {
                final isFemale = (child.gender ?? '').toLowerCase() == 'female';
                return Container(
                  margin: const EdgeInsets.only(right: AppSpacing.md),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: isFemale
                        ? AppColors.errorLight.withValues(alpha: 0.1)
                        : AppColors.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(
                      color: isFemale
                          ? AppColors.error.withValues(alpha: 0.1)
                          : AppColors.primary.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: isFemale
                            ? AppColors.errorLight
                            : AppColors.infoLight,
                        child: Icon(
                          isFemale ? Icons.face_3_rounded : Icons.face_rounded,
                          color: isFemale ? AppColors.error : AppColors.info,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            child.childName ?? '',
                            style: AppTypography.titleSmall
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${child.age} Years',
                            style: AppTypography.labelSmall
                                .copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
