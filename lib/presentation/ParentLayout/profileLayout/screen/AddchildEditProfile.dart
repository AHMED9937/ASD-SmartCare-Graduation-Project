import 'package:asdsmartcare/presentation/ParentLayout/profileLayout/controller/cubit/GetParentChildsCubit/parentchild_list_cubit.dart';
import 'package:asdsmartcare/presentation/ParentLayout/profileLayout/controller/cubit/GetParentChildsCubit/parentchild_list_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/profileLayout/widgets/AddchildProfile.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/SignUp/Widgets/AddChildForm.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addchildeditprofile extends StatefulWidget {
  final String ParentId;
  const Addchildeditprofile({super.key, required this.ParentId});
  @override
  State<Addchildeditprofile> createState() => _AddchildeditprofileState();
}

class _AddchildeditprofileState extends State<Addchildeditprofile> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ParentChildsListCubit()..getParentChildsList(widget.ParentId),
      child: BlocConsumer<ParentChildsListCubit, ParentChildsListStates>(
        listener: (context, state) {
          final cubit = ParentChildsListCubit.get(context);
          if (state is addChildSuccsessStates || state is DeleteChildSuccsessStates) {
            cubit.getParentChildsList(widget.ParentId);
          } else if (state is addChildFailedStates || state is DeleteChildFailedStates) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Operation failed")));
          }
        },
        builder: (context, state) {
          final cubit = ParentChildsListCubit.get(context);
          final hasChildren = cubit.children?.childs?.isNotEmpty == true;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarWithText(context, "Childs Management"),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      if (state is GetParentChildsListLoadingStates) const CircularProgressIndicator(),
                      if ((state is GetParentChildsListSuccsessStates && hasChildren) || state is DeleteChildLoadingStates)
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          itemCount: cubit.children!.childs!.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final child = cubit.children!.childs![index];
                            final isFemale = (child.gender ?? '').toLowerCase() == 'female';
                            final bgColor = isFemale ? const Color(0xFFCCDFFF) : const Color(0xFF133E87);
                            final textColor = isFemale ? const Color(0xFF133E87) : Colors.white;

                            return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextUtils.textHeader(
                                            child.childName ?? '',
                                            headerTextColor: textColor,
                                          ),
                                          const SizedBox(height: 4),
                                          TextUtils.textDescription(
                                            child.gender ?? '',
                                            disTextColor: textColor,
                                            fontSize: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextUtils.textDescription(
                                          '${child.age ?? ''} yrs',
                                          disTextColor: textColor,
                                          fontSize: 14,
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                            padding: EdgeInsets.zero,
                                            tapTargetSize:
                                                MaterialTapTargetSize.shrinkWrap,
                                          ),
                                          onPressed: () => context
                                              .read<ParentChildsListCubit>()
                                              .DeleteParentChild(child.sId!),
                                          child: const Text('Remove'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                       },
                        )
                      else if (state is GetParentChildsListSuccsessStates && !hasChildren)
                        SizedBox(
                          height: 200,
                          child: Center(
                            child: TextUtils.textHeader(
                              'No children added yet',
                              fontSize: 18,
                            ),
                          ),
                        ),

                      const SizedBox(height: 20),

                      AddchildProfilForm(),
                      const SizedBox(height: 24),

                      if (!hasChildren)
                        ConditionalBuilder(
                          condition: state is! AddChildLoadingStates,
                          builder: (_) => AppButtons.containerTextButton(
                            containerColor: const Color(0xFFCCDFFF),
                            TextUtils.textHeader(
                              "Add Child",
                              headerTextColor: const Color(0xFF133E87),
                              fontSize: 20,
                            ),
                            () {
                              if (cubit.addParentFormKey.currentState!.validate()) {
                                cubit.addChild(parentId: widget.ParentId);
                              }
                            },
                          ),
                          fallback: (_) => const Center(child: CircularProgressIndicator()),
                        ),

                      AppButtons.containerTextButton(
                        TextUtils.textHeader("Done", headerTextColor: Colors.white, fontSize: 16),
                        () => Navigator.pop(context),
                      ),
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
