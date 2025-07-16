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
    dynamic parent,
    dynamic child,
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
              length: 2,
              child: Column(
                children: [
                  // Header with handle and close button
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      Tab(text: 'Create Session'),
                    ],
                  ),
                  // Content
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Info Tab
                        SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Avatar
                                Center(
                                  child: CircleAvatar(
                                    radius: 48,
                                    backgroundColor: Colors.grey[200],
                                    child: const Icon(Icons.person,
                                        size: 48, color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                _buildDetailRow(
                                    'Parent Name', parent.userName ?? '-'),
                                const SizedBox(height: 16),
                                _buildDetailRow(
                                    'Child Name', child.childName ?? '-'),
                                const SizedBox(height: 16),
                                _buildDetailRow(
                                    'Child Age', child.age?.toString() ?? '-'),
                                const SizedBox(height: 16),
                                _buildDetailRow(
                                    'Child Gender', child.gender ?? '-'),
                              ],
                            ),
                          ),
                        ),
                        // Create Session Tab
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                              controller: scrollController,
                              child: SessionForm(
                                Parentid: parent.id,
                              )),
                        ),
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
    child: BlocBuilder<RegisteredChildrenListCubit,
        GetRegisteredChildrenListStates>(
      builder: (context, state) {
        final cubit = RegisteredChildrenListCubit.get(context);
        final parents = cubit.registeredchildren?.parents;

        // --- Fixed null/empty check here ---
        final validParents = (parents != null && parents.isNotEmpty)
            ? parents.where((p) => p.childs != null && p.childs!.isNotEmpty).toList()
            : <dynamic>[];
        // -------------------------------------

        return Scaffold(
          appBar: AppBarWithText(context, "Registered Children"),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: state is GetRegisteredChildrenListLoadingStates
                ? const Center(child: CircularProgressIndicator())
                : validParents.isEmpty
                    ? const Center(
                        child: Text(
                          'No registered children found.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListView.separated(
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
                          itemCount: validParents.length,
                          itemBuilder: (context, index) {
                            final parent = validParents[index];
                            final child = parent.childs!.first;

                            return InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () =>
                                  showChildDetailsSheet(context, parent, child),
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(width: 1),
                                ),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundColor: Colors.grey[300],
                                        child: const Icon(
                                          Icons.person,
                                          size: 32,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              ' Age: ${child.age}  •   Gender: ${child.gender}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
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

// SessionForm widget to capture session details with customized UI
class SessionForm extends StatefulWidget {
  @override
  _SessionFormState createState() => _SessionFormState();

  final String Parentid;
  const SessionForm({
    Key? key,
    required this.Parentid,
  }) : super(key: key);
}

class _SessionFormState extends State<SessionForm> {
  final _formKey = GlobalKey<FormState>();

  int? sessionNumber;
  DateTime? sessionDate;
  String? statusOfSession;
  List<String> comments = [];

  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: sessionDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF133E87), // header background
              onPrimary: Colors.white, // header text
              onSurface: Color(0xFF133E87), // body text
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white, // button text
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != sessionDate) {
      setState(() {
        sessionDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: BlocProvider(
        create: (context) => RegisteredChildrenListCubit(),
        child: BlocConsumer<RegisteredChildrenListCubit,
            GetRegisteredChildrenListStates>(
          listener: (context, state) {
            // no SnackBars any more
          },
          builder: (context, state) {
            if (state is CreatSessionLoadingStates) {
              return const Center(child: CircularProgressIndicator());
            }

            // SUCCESS: show a simple success screen
            if (state is CreatSessionSuccsessStates) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 80, color: Colors.green),
                      const SizedBox(height: 16),
                      const Text(
                        'Session Created!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 32),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        icon: const Icon(
                         Icons.add,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Create Another',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () =>
                            RegisteredChildrenListCubit.get(context).reset(),
                      ),
                   
                    
                    ],
                  ),
                ),
              );
            }

            // ERROR: show a simple error screen
            if (state is CreatSessionFailedStates) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error, size: 80, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        "Error",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Try Again',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () =>
                            RegisteredChildrenListCubit.get(context).reset(),
                      ),
                    ],
                  ),
                ),
              );
            }

            // INITIAL / DEFAULT: show your form
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildNumberField(),
                  const SizedBox(height: 16),
                  _buildDateField(context),
                  const SizedBox(height: 16),
                  _buildStatusField(),
                  const SizedBox(height: 24),

                  // Comments section (unchanged)
                  Text('Comments',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF133E87))),
                  const SizedBox(height: 10),
                  ...comments.map((c) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xFF133E87)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child:
                            Text(c, style: TextStyle(color: Color(0xFF133E87))),
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _commentController,
                          decoration: _inputDecoration('Add a comment'),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Color(0xFF133E87)),
                        onPressed: () {
                          if (_commentController.text.trim().isNotEmpty) {
                            setState(() {
                              comments.add(_commentController.text.trim());
                              _commentController.clear();
                            });
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Submit button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF133E87),
                      overlayColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final result = {
                          'parentId': widget.Parentid,
                          'session_number': sessionNumber,
                          'session_date':
                              sessionDate!.toIso8601String().split('T')[0],
                          'statusOfSession': statusOfSession,
                          'comments': comments,
                        };
                        RegisteredChildrenListCubit.get(context)
                            .CreateSession(result);
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNumberField() => TextFormField(
        decoration: _inputDecoration('Session Number'),
        keyboardType: TextInputType.number,
        onSaved: (val) => sessionNumber = int.tryParse(val!),
        validator: (val) => val!.isEmpty ? 'Required' : null,
        style: TextStyle(color: Color(0xFF133E87)),
      );

  Widget _buildDateField(BuildContext context) => InkWell(
        onTap: () => _pickDate(context),
        child: InputDecorator(
          decoration: _inputDecoration('Session Date'),
          child: Text(
            sessionDate == null
                ? 'Select Date'
                : sessionDate!.toLocal().toString().split(' ')[0],
            style: TextStyle(
                color: sessionDate == null ? Colors.grey : Color(0xFF133E87)),
          ),
        ),
      );

  Widget _buildStatusField() => DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        decoration: _inputDecoration('Status of Session'),
        items: ['done', 'coming']
            .map((status) => DropdownMenuItem(
                  value: status,
                  child:
                      Text(status, style: TextStyle(color: Color(0xFF133E87))),
                ))
            .toList(),
        onChanged: (val) => setState(() => statusOfSession = val),
        validator: (val) => val == null ? 'Required' : null,
      );

  InputDecoration _inputDecoration(String label) => InputDecoration(
        fillColor: Colors.white,
        labelText: label,
        labelStyle: TextStyle(color: Color(0xFF133E87)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF133E87)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF133E87), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      );
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
