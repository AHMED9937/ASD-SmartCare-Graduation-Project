import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/DoctorSessions/cubit/doctor_sessions_cubit.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/DoctorSessions/cubit/doctor_sessions_state.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Widgets/doctorReviews.dart';
import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/screens/SessionDeatile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionsScreen extends StatelessWidget {
  final String status;

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

void showChildDetailsSheet(
  BuildContext context,
   parent,
   child,
   session,
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
                        child: SesstionReview(session: session),
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

  const SessionsScreen({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorSesstionListCubit()..getDoctorSesstionList(status: status),
      child: Scaffold(
        appBar: AppBarWithText(context, '$status sessions'),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: BlocConsumer<DoctorSesstionListCubit, GetDoctorSesstionListStates>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubit = DoctorSesstionListCubit.get(context);

              if (state is GetDoctorSesstionListLoadingStates) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetDoctorSesstionListFailedStates) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      const Text(
                        'Something went wrong',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Please try again later.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => cubit.getDoctorSesstionList(status: status),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (cubit.Sessions?.data == null || cubit.Sessions!.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.inbox, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text(
                        'No sessions found',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You have no $status sessions at the moment.',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(

                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                itemCount: cubit.Sessions!.data!.length,
                itemBuilder: (context, index) {
                  final session = cubit.Sessions!.data![index];
                  final parent = session.parent!;

                  // Fallback if no child
                  if (parent.childs == null || parent.childs!.isEmpty) {
                    return _SessionCard(
                      userName: parent.userName ?? '',
                      childName: null,
                      age: null,
                      gender: null,
                      date: "sessionDate",
                    );
                  }

                  final child = parent.childs!.first;
                   
                  return InkWell(
                    onTap: ()=>showChildDetailsSheet(context, parent, child,session),
                    child: _SessionCard(
                      userName: parent.userName ?? '',
                      childName: child.childName,
                      age: '${child.age}',
                      gender: child.gender,
                      date: "sessionDate",
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final String userName;
  final String? childName;
  final String ? age;
  final String? gender;
  final String? date;

  const _SessionCard({
    Key? key,
    required this.userName,
    this.childName,
    this.age,
    this.gender,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(

      
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[200],
              child: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  if (childName != null) ...[
                    const SizedBox(height: 4),
                    Text(childName!),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (age != null) Text('Age: $age'),
                      if (age != null && gender != null) const SizedBox(width: 16),
                      if (gender != null) Text('Gender: $gender'),
                    ],
                  ),
                ],
              ),
            ),
            if (date != null) ...[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    date!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              )
            ],
          ],
        ),
      ),
    
    
    );
  }
}
