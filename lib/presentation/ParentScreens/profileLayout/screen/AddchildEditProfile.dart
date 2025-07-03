import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/controller/cubit/GetParentChildsCubit/parentchild_list_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/controller/cubit/GetParentChildsCubit/parentchild_list_state.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/widgets/AddchildProfile.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/SignUp/Widgets/AddChildForm.dart';
import 'package:asdsmartcare/presentation/SignUp/screen/AddChildScreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

          if (state is addChildSuccsessStates) {
            cubit.getParentChildsList(widget.ParentId);
          }
          else if (state is DeleteChildSuccsessStates) {
            cubit.getParentChildsList(widget.ParentId);
          }
          else if (state is addChildFailedStates || state is DeleteChildFailedStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Operation failed"))
            );
          }
        },
        builder: (context, state) {
          final cubit = ParentChildsListCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarWithText(context, "Childs Management"),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 14),
                     
                     
                      const SizedBox(height: 40),

                      if (state is GetParentChildsListLoadingStates)
                        const CircularProgressIndicator(),

                      if (state is GetParentChildsListSuccsessStates &&
                          cubit.children!.childs!.isNotEmpty||state is  DeleteChildLoadingStates)
                          ConditionalBuilder(condition: state is !DeleteChildLoadingStates,
                            builder:(_)=> SizedBox(
                              
                              height: 190,
                              child: ListView.separated(
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          itemCount: cubit.children!.childs!.length,
                                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                                          itemBuilder: (context, index) {
                                            final child = cubit.children!.childs![index];
                                            final isFemale =
                                                (child.gender ?? '').toLowerCase() == 'female';
                                            final bgColor = isFemale
                                                ? const Color(0xFFCCDFFF)
                                                : const Color(0xFF133E87);
                                            final textColor =
                                                isFemale ? const Color(0xFF133E87) : Colors.white;
                              
                                            return Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 16),
                                              padding:
                                                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                              decoration: BoxDecoration(
                                                color: bgColor,
                                                borderRadius: BorderRadius.circular(23),
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      TextUtils.textDescription(
                              child.age ?? '',
                              disTextColor: textColor,
                              fontSize: 15,
                                                      ),
                                                      const SizedBox(height: 8),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  context
                                      .read<ParentChildsListCubit>()
                                      .DeleteParentChild(child.sId!);
                                },
                                child: const Text('Remove'),
                              ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                            ),
                         
                         fallback: (_)=>Center(child: CircularProgressIndicator(),),
                          ),
        
                      const SizedBox(height: 20),
                      AddchildProfilForm(),
                      const SizedBox(height: 47),

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
                        fallback: (_) =>
                            const Center(child: CircularProgressIndicator()),
                      ),

                      AppButtons.containerTextButton(
                        TextUtils.textHeader("Done",
                            headerTextColor: Colors.white, fontSize: 20),
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
