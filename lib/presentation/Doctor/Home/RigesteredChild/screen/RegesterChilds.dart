import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Widgets/doctorReviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/RigesteredChild/cubit/registered_children_cubit.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/RigesteredChild/cubit/registered_children_state.dart';

/// Screen showing all registered children and, on tap, detailed bottom sheet.
class RegisteredChildrenScreen extends StatelessWidget {
  const RegisteredChildrenScreen({Key? key}) : super(key: key);
void showChildDetailsSheet(
  BuildContext context,
   parent,
   child,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                // Header with handle and close button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4,
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    
                    ],
                  ),
                ),
                // Tabs
                TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'Info'),
                    Tab(text: 'Reviews'),
                    Tab(text: 'My Feedbacks'),
                  ],
                ),
                // Content
                Expanded(
                  child: TabBarView(
                    children: [
                      // Info Tab with labeled fields
                      SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Avatar centered
                              Center(
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundColor: Colors.grey[200],
                                  child: const Icon(Icons.person, size: 48, color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Parent Name
                              _buildDetailRow('Parent Name', parent.userName ?? '-'),
                              const SizedBox(height: 16),
                              // Child Name
                              _buildDetailRow('Child Name', child.childName ?? '-'),
                              const SizedBox(height: 16),
                              // Age
                              _buildDetailRow('Child Age', child.age ?? '-'),
                              const SizedBox(height: 16),
                              // Gender
                              _buildDetailRow('Child Gender', child.gender ?? '-'),
                            ],
                          ),
                        ),
                      ),
                      // Reviews Tab
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ReviewListView(
                          DoctorId: CacheHelper.getData(key: 'id'),
                         
                        ),
                      ),
                      SizedBox(),
                    ],
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

/// Helper to build a label-value row

/// Helper to build a label-value row
Widget _buildDetailRow(String label, String value) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}

@override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisteredChildrenListCubit()..getRegisteredChildrenList(),
      child: BlocBuilder<RegisteredChildrenListCubit, GetRegisteredChildrenListStates>(
        builder: (context, state) {
          final cubit = RegisteredChildrenListCubit.get(context);
          final parents = cubit.registeredchildren?.parents;

          return Scaffold(
            appBar:AppBarWithText(context, "Registered Children"),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: state is GetRegisteredChildrenListLoadingStates
                  ? const Center(child: CircularProgressIndicator())
                  : (parents == null || parents.isEmpty)
                      ? const Center(
                          child: Text(
                            'No registered children found.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : Padding(
                        padding: const EdgeInsets.only(top:  20),
                        child: ListView.separated(
                            separatorBuilder: (_, __) => const SizedBox(height: 16),
                            itemCount: parents.length,
                            itemBuilder: (context, index) {
                              final parent = parents[index];
                              final child = parent.childs!.first;
                              return InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () => showChildDetailsSheet(context, parent, child),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: BorderSide(width: 1)
                                  ),
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(30),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 28,
                                          backgroundColor: Colors.grey[300],
                                          child: 
                                              const Icon(
                                                  Icons.person,
                                                  size: 32,
                                                  color: Colors.white,
                                                ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                parent.userName ?? '',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF133E87),
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                child.childName ?? '',
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                ' Age: ${child.age}  •   Gender: ${child.gender}',
                                                style: const TextStyle(
                                                    fontSize: 12, color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      ),
            ),
          );
        },
      ),
    );
  }
}

/// Dummy data structures to satisfy the code references
class ParentData {
  final String? userName;
  final List<ChildData>? childs;
  ParentData({this.userName, this.childs});
}

class ChildData {
  final String? childName;
  final String age;
  final String gender;
  ChildData({this.childName, required this.age, required this.gender});
}
