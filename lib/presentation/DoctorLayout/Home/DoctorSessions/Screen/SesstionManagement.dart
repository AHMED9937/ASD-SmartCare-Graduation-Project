import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:asdsmartcare/presentation/DoctorLayout/Home/DoctorSessions/cubit/doctor_sessions_cubit.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/Home/DoctorSessions/cubit/doctor_sessions_state.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/Home/DoctorSessions/model/DoctorSessions.dart';

class SessionManagement extends StatefulWidget {
  const SessionManagement({Key? key, required this.sessionID}) : super(key: key);

  final String sessionID;

  @override
  _SessionManagementState createState() => _SessionManagementState();
}

class _SessionManagementState extends State<SessionManagement> {
  final List<String> _comments = [];
  final TextEditingController _feedbackController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _feedbackController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _submitFeedback(DoctorSessionListCubit cubit) async {
    final text = _feedbackController.text.trim();
    if (text.isEmpty) return;
    setState(() => _comments.add(text));
    _feedbackController.clear();
    await cubit.updateSessionComments(_comments, widget.sessionID);
    _scrollToBottom();
  }Future<void> _editComment(int index, DoctorSessionListCubit cubit) async {
  final controller = TextEditingController(text: _comments[index]);
  final edited = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      // Keep some margin from the screen edges
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      title: const Text('Edit Feedback'),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            // Never exceed 40% of screen height
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: TextField(
            controller: controller,
            maxLines: null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, controller.text.trim()),
          child: const Text('Save'),
        ),
      ],
    ),
  );

  if (edited != null && edited.isNotEmpty) {
    setState(() => _comments[index] = edited);
    await cubit.updateSessionComments(_comments, widget.sessionID);
  }
}
  Future<void> _deleteComment(int index, DoctorSessionListCubit cubit) async {
    final removed = _comments[index];
    setState(() => _comments.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted: $removed'), duration: const Duration(seconds: 2)),
    );
    await cubit.updateSessionComments(_comments, widget.sessionID);
  }
  Future<void> _showAddFeedbackDialog(DoctorSessionListCubit cubit) async {
    
    _feedbackController.clear();final text = await showDialog<String>(
  context: context,
  builder: (_) => AlertDialog(
    // Rounded corners & light grey background
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    backgroundColor: Colors.grey[100],
    title: const Text(
      'New Feedback',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
    content: TextField(
      controller: _feedbackController,
      autofocus: true,
      maxLines: null,
      decoration: InputDecoration(
        // filled white field with rounded border
        filled: true,
        fillColor: Colors.white,
        hintText: 'Enter your feedback',
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    ),
    actionsPadding: const EdgeInsets.only(right: 12, bottom: 8),
    actions: [
      // Cancel as a grey “text” button
      TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white
        ),
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel',style: TextStyle(color: Color(0XFF133E87)),),
      ),
      // Add as an elevated, accent‐colored button
      ElevatedButton(
        
        style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => Navigator.pop(context, _feedbackController.text.trim()),
        child: const Text('Add',style: TextStyle(color: Color(0XFF133E87)),),
      ),
    ],
  ),
);
  if (text != null && text.isNotEmpty) {
      await _submitFeedback(cubit);
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorSessionListCubit>(
      create: (_) => DoctorSessionListCubit()..fetchSessionById(widget.sessionID),
      child: BlocConsumer<DoctorSessionListCubit, GetDoctorSessionListStates>(
        listener: (context, state) {
          if (state is GetSpecificSessionSuccessStates) {
            final session = context.read<DoctorSessionListCubit>().selectedSession;
            setState(() {
              _comments
                ..clear()
                ..addAll(session?.comments ?? []);
            });
            WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
          }
          if (state is UpdateDoctorSessionSuccessStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Feedback saved'), duration: Duration(seconds: 2)),
            );
          } else if (state is UpdateDoctorSessionFailedStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to save feedback'), duration: Duration(seconds: 2)),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<DoctorSessionListCubit>();
          final session = cubit.selectedSession;
          final date = session?.sessionDate;

          return Scaffold(
           
            body: state is GetSpecificSessionLoadingStates
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          itemCount: _comments.length,
                          itemBuilder: (context, index) {
                            final comment = _comments[index];
                            final timestamp = date != null
                                ? DateFormat('MMM d, yyyy  hh:mm a').format(date)
                                : '';
                      
                            return Card(
                              color: Theme.of(context).primaryColor,
                              elevation: 1,
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Text(
                                      comment,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    if (timestamp.isNotEmpty) ...[
                                      const SizedBox(height: 6),
                                      Text(
                                        timestamp,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: PopupMenuButton<String>(
                                        color: Colors.white,
                                        icon: const Icon(Icons.more_vert, size: 20, color: Colors.white),
                                        onSelected: (value) {
                                          if (value == 'edit') _editComment(index, cubit);
                                          else if (value == 'delete') _deleteComment(index, cubit);
                                        },
                                        itemBuilder: (_) => const [
                                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Row(
                            children: [Padding(
  padding: const EdgeInsets.symmetric(vertical: 12),
  child: Center(
    child: ElevatedButton.icon(
      
      icon: const Icon(Icons.add_comment,color: Color(0xFF133E87),),
      label: const Text('Write Feedback',style: TextStyle(color: Color(0xFF133E87)),),
      style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      onPressed: () => _showAddFeedbackDialog(cubit),
    ),
  ),
),const SizedBox(width: 8),
                             
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
