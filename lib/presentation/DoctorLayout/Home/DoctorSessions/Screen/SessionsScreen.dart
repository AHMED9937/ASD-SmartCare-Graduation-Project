import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/DoctorSessions/Screen/SesstionManagement.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/DoctorSessions/cubit/doctor_sessions_cubit.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/DoctorSessions/cubit/doctor_sessions_state.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Widgets/doctorReviews.dart';
import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/screens/SessionDeatile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
            fontSize: 14,
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
                        child:  ReviewListView(
                          ID:session.id,
                          showAllReviews: false,
                         
                        ),
                      ),
                      SessionManagement(sessionID: session.id),
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
      create: (_) => DoctorSessionListCubit()..fetchSessions(status: status),
      child: Scaffold(
        appBar: AppBarWithText(context, '$status sessions'),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: BlocConsumer<DoctorSessionListCubit, GetDoctorSessionListStates>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubit = DoctorSessionListCubit.get(context);

              if (state is GetDoctorSessionListLoadingStates) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetDoctorSessionListFailedStates) {
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
                        onPressed: () => cubit.fetchSessions(status: status),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (cubit.sessions?.data == null || cubit.sessions!.data!.isEmpty) {
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
                itemCount: cubit.sessions!.data!.length,
                itemBuilder: (context, index) {
                  final session = cubit.sessions!.data![index];
                  final parent = session.parent!;

                  // Fallback if no child
                  if (parent.childs == null || parent.childs!.isEmpty) {
                    return _SessionCard(
                      userName: parent.userName ?? '',
                      childName: null,
                      age: null,
                      gender: null,
                      date: session.createdAt,
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
                      date: session.createdAt,
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
}class _SessionCard extends StatelessWidget {
  final String userName;
  final String? childName;
  final String? age;
  final String? gender;
  final DateTime? date;

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
    final theme = Theme.of(context);
    final displayName = childName ?? 'No child';
    final details = <String>[];
    if (age != null) details.add('$age');
    if (gender != null) details.add('$gender');
    final infoLine = details.join(' • ');
    final dateStr = date != null ? DateFormat('dd MMM yyyy').format(date!) : '';
    final timeStr = date != null ? DateFormat('hh:mm a').format(date!) : '';

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: theme.primaryColor.withOpacity(0.1),
          child: Icon(Icons.child_care, color: theme.primaryColor, size: 28),
        ),
        title: Text(
          displayName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: infoLine.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(infoLine, style: TextStyle(color: Colors.black54)),
              )
            : null,
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (dateStr.isNotEmpty)
              Text(dateStr, style: TextStyle(color: theme.primaryColor)),
            if (timeStr.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(timeStr, style: TextStyle(color: theme.primaryColor)),
              ),
          ],
        ),
      ),
    );
  }
}
