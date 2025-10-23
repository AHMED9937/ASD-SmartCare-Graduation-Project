import 'package:asdsmartcare/parent/my_children/controllers/children_list_cubit.dart';
import 'package:asdsmartcare/parent/my_children/controllers/children_list_state.dart';
import 'package:asdsmartcare/parent/my_children/views/add_child_profile_screen.dart';
import 'package:asdsmartcare/parent/my_children/views/children_list_screen.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditChildScreen extends StatefulWidget {
  final String parentId;
  const EditChildScreen({super.key, required this.parentId});
  @override
  State<EditChildScreen> createState() => _EditChildScreenState();
}

class _EditChildScreenState extends State<EditChildScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ParentChildrenListCubit()..getParentChildrenList(widget.parentId),
      child: BlocConsumer<ParentChildrenListCubit, ParentChildrenListStates>(
        listener: (context, state) {
          final cubit = ParentChildrenListCubit.get(context);
          if (state is AddChildSuccessStates ||
              state is DeleteChildSuccessStates) {
            cubit.getParentChildrenList(widget.parentId);
          } else if (state is AddChildFailedStates ||
              state is DeleteChildFailedStates) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Operation failed')));
          }
        },
        builder: (context, state) {
          final cubit = ParentChildrenListCubit.get(context);
          final hasChildren = cubit.children?.childs?.isNotEmpty ?? false;
          final isInitialLoading = state is ParentChildrenListInitialStates ||
              state is GetParentChildrenListLoadingStates;

          return Scaffold(
            appBar: const AppHeader(),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageHeader(
                    title: 'Children Management',
                    subtitle: 'View and manage your registered children.',
                  ),
                  Expanded(
                    child: isInitialLoading
                        ? const LoadingView()
                        : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.lg),
                              child: Column(
                                children: [
                                  if (hasChildren ||
                                      state is DeleteChildLoadingStates)
                                    ParentChildrenList(
                                      parentId: widget.parentId,
                                      openEdit: true,
                                    ),
                                  if (state
                                          is GetParentChildrenListSuccessStates &&
                                      !hasChildren)
                                    SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: Text(
                                          'No children added yet',
                                          style:
                                              AppTypography.titleLarge.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (!hasChildren) ...[
                                    if (state
                                        is GetParentChildrenListSuccessStates) ...[
                                      const SizedBox(height: AppSpacing.lg),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: AppSpacing.sm),
                                        child: Text(
                                          'Add New Child',
                                          style: AppTypography.titleMedium
                                              .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: AppSpacing.md),
                                    const AddChildProfileForm(),
                                    const SizedBox(height: AppSpacing.xl),
                                    AppButton(
                                      label: 'Add Child',
                                      isLoading: state is AddChildLoadingStates,
                                      onPressed: () {
                                        if (cubit.addParentFormKey.currentState!
                                            .validate()) {
                                          cubit.addChild(
                                              parentId: widget.parentId);
                                        }
                                      },
                                    ),
                                  ],
                                  const SizedBox(height: AppSpacing.lg),
                                  AppButton(
                                    label: 'Done',
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const SizedBox(height: AppSpacing.xxl),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
