import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/my_children/views/add_child_form.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/parent_signup_cubit.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/parent_signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddChildScreen extends StatefulWidget {
  final String parentId;
  const AddChildScreen({super.key, required this.parentId});
  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ParentSignUpCubit(),
      child: BlocConsumer<ParentSignUpCubit, ParentSignUpState>(
        listener: (context, state) {
          if (state is AddChildSuccessState) {
            ParentSignUpCubit.get(context).ParentChilds.add(buildChildInfoCard(
                  age: ParentSignUpCubit.get(context)
                      .ChildAgetextcontroller
                      .text,
                  name: ParentSignUpCubit.get(context)
                      .ChildNametextcontroller
                      .text,
                  gender: ParentSignUpCubit.get(context)
                      .ChildGendertextcontroller
                      .text,
                ));
          } else if (state is AddChildErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('')));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackground,
            appBar: const AppHeader(),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PageHeader(
                        title: 'Add Child',
                        subtitle:
                            'Register your child to start tracking their progress.',
                      ),
                      if (ParentSignUpCubit.get(context)
                          .ParentChilds
                          .isNotEmpty) ...[
                        SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: ParentSignUpCubit.get(context)
                                .ParentChilds
                                .length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: AppSpacing.sm),
                                child: SizedBox(
                                  width: 300,
                                  child: ParentSignUpCubit.get(context)
                                      .ParentChilds[index],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                      if (ParentSignUpCubit.get(context).ParentChilds.isEmpty)
                        const AddChildForm(),
                      const SizedBox(height: AppSpacing.xxxl),
                      if (ParentSignUpCubit.get(context).ParentChilds.isEmpty)
                        AppButton(
                          label: 'Add Child',
                          isLoading: state is AddChildLoadingState,
                          onPressed: () {
                            if (ParentSignUpCubit.get(context)
                                .addParentFormKey
                                .currentState!
                                .validate()) {
                              ParentSignUpCubit.get(context)
                                  .addChild(parentId: widget.parentId);
                            }
                          },
                        ),
                      // Provide spacing or conditional rendering for the Next Step button
                      if (ParentSignUpCubit.get(context)
                          .ParentChilds
                          .isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.lg),
                          child: AppButton(
                            label: 'Next Step',
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/login',
                                (Route<dynamic> route) => false,
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildChildInfoCard({
  required String name,
  required String gender,
  required String age,
}) {
  final bool isMale = gender.toLowerCase() == 'male';
  final Color bgColor = isMale ? AppColors.primary : AppColors.primaryLighter;
  final Color textColor = isMale ? AppColors.onPrimary : AppColors.primary;

  return DecoratedBox(
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: AppRadius.xlRadius,
    ),
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name and age row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: AppTypography.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  '${age}yo',
                  style: AppTypography.bodyMedium.copyWith(
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            // Gender row
            Row(
              children: [
                Text(
                  gender,
                  style: AppTypography.bodyMedium.copyWith(
                    color: textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
