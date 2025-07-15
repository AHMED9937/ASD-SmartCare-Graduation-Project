import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/controller/cubit/GetParentData/parent_data_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/controller/cubit/GetParentData/parent_data_state.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/screen/EditProfile.dart';
import 'package:asdsmartcare/presentation/ParentScreens/profileLayout/widgets/ParentsChilds.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetParentDataCubit()..getParentData(),
      child: BlocConsumer<GetParentDataCubit, GetParentDataStates>(
        listener: (_, __) {},
        builder: (context, state) {
          final cubit = GetParentDataCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: Navigator.canPop(context)
                ? AppBarWithText(context, "Profile Info")
                : AppBar(
                  forceMaterialTransparency: true,
                    title: TextUtils.textHeader("Profile Info", fontSize: 24),
                    backgroundColor: Colors.white,
                    centerTitle: true,
                  ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: ConditionalBuilder(
                condition: state is! GetParentDataLoadingStates,
                builder: (_) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ─── PROFILE HEADER CARD ───────────────────────────
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: cubit.Cur_Parent!.data!.image != null
                                  ? NetworkImage(cubit.Cur_Parent!.data!.image!)
                                  : null,
                              child: cubit.Cur_Parent!.data!.image == null
                                  ? Icon(Icons.person, size: 60, color: Colors.grey)
                                  : null,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextUtils.textHeader(
                                  cubit.Cur_Parent!.data!.userName ?? "",
                                  headerTextColor: Colors.black,
                                ),
                                SizedBox(height: 8),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EditParentProfileScreen(
                                        parentD: cubit.Cur_Parent!,
                                        ),
                                      ),
                                    ).then((_) {
                                      // refresh when EditProfileScreen returns
                                      context.read<GetParentDataCubit>().getParentData();
                                    });
                                  },
                                  icon: Icon(Icons.edit, color: Colors.white, size: 18),
                                  label: Text("Edit", style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF133E87),
                                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),

                      // ─── CHILDREN SECTION ────────────────────────────
                      TextUtils.textHeader("Your Children", fontSize: 20),
                      SizedBox(height: 12),
                      // fixed height so ListView.builder can render inside scroll-view
                      SizedBox(
                        height: 120,
                        child: Parentchilds(
                          parentId: cubit.Cur_Parent!.data!.id!,
                          openEdit: false,
                        ),
                      ),


                      // ─── PARENT DETAILS SECTION ───────────────────────
                      TextUtils.textHeader("Parent Details", fontSize: 20),
                      SizedBox(height: 20),
                      _buildDetailRow("Age", cubit.Cur_Parent!.data!.age.toString()),
                      _buildDetailRow("Email", cubit.Cur_Parent!.data!.email ?? "—"),
                      _buildDetailRow("Phone", cubit.Cur_Parent!.data!.phone ?? "—"),
                      _buildDetailRow("address", cubit.Cur_Parent!.data!.address ?? "—"),
                      
                      // add more fields as needed...
                    ],
                  ),
                ),
                fallback: (_) => Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Expanded(child: Text(value, style: TextStyle(fontSize: 14, color: Colors.grey))),
        ],
      ),
    );
  }
}
