import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/controller/cubit/GetParentChildsCubit/parentchild_list_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/controller/cubit/GetParentChildsCubit/parentchild_list_state.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';

class Parentchilds extends StatelessWidget {
  final String parentId;
  final bool openEdit;

  Parentchilds({
    Key? key,
    required this.parentId,
    this.openEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ParentChildsListCubit()..getParentChildsList(parentId),
      child: BlocConsumer<ParentChildsListCubit, ParentChildsListStates>(
        listener: (context, state) {
          // on delete success, re-fetch
          if (state is DeleteChildSuccsessStates) {
            context
                .read<ParentChildsListCubit>()
                .getParentChildsList(parentId);
          }
          // handle errors
          if (state is GetParentChildsListFailedStates ||
              state is DeleteChildFailedStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state is GetParentChildsListFailedStates
                    ? "Failed to load children"
                    : "Failed to delete child"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          // loading spinner
          if (state is GetParentChildsListLoadingStates ||
              state is DeleteChildLoadingStates) {
            return const Center(child: CircularProgressIndicator());
          }

          // always read from cubit
          final list = ParentChildsListCubit.get(context)
                  .children
                  ?.childs ??
              [];

          if (list.isEmpty) {
            return const Center(child: Text("No children found."));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final child = list[index];
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
                  children: [
                   
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
                        if (openEdit)
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
          );
        },
      ),
    );
  }
}
