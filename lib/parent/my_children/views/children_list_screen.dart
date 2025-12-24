import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asdsmartcare/parent/my_children/controllers/children_list_cubit.dart';
import 'package:asdsmartcare/parent/my_children/controllers/children_list_state.dart';

class ParentChildrenList extends StatelessWidget {
  final String parentId;
  final bool openEdit;

  const ParentChildrenList({
    super.key,
    required this.parentId,
    this.openEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParentChildsListCubit, ParentChildsListStates>(
      listener: (context, state) {
        // on delete success, re-fetch
        if (state is DeleteChildSuccsessStates) {
          context.read<ParentChildsListCubit>().getParentChildsList(parentId);
        }
        // handle errors
        if (state is GetParentChildsListFailedStates ||
            state is DeleteChildFailedStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state is GetParentChildsListFailedStates
                  ? 'Failed to load children'
                  : 'Failed to delete child'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        // loading spinner
        if (state is GetParentChildsListinitialStates ||
            state is GetParentChildsListLoadingStates ||
            state is DeleteChildLoadingStates) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.xxl),
              child: LoadingView(),
            ),
          );
        }

        // always read from cubit
        final list = ParentChildsListCubit.get(context).children?.childs ?? [];

        if (list.isEmpty) {
          return Center(
              child: Text(
            'No children found.',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ));
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final child = list[index];
            final isFemale = (child.gender ?? '').toLowerCase() == 'female';
            return AppCard(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isFemale
                          ? AppColors.primaryLighter
                          : AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(
                      isFemale ? Icons.female : Icons.male,
                      color: isFemale ? AppColors.primary : AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          child.childName ?? '',
                          style: AppTypography.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${child.gender ?? ''} • ${child.age ?? ''} years',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (openEdit)
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: AppColors.error,
                      ),
                      onPressed: () {
                        context
                            .read<ParentChildsListCubit>()
                            .DeleteParentChild(child.sId!);
                      },
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
