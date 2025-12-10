import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/sessions/manage/views/widgets/feedback_card.dart';
import 'package:asdsmartcare/doctor/sessions/manage/views/widgets/feedback_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:asdsmartcare/doctor/sessions/list/controllers/sessions_list_cubit.dart';
import 'package:asdsmartcare/doctor/sessions/list/controllers/sessions_list_state.dart';

/// Screen for managing session feedback and comments.
class SessionManagement extends StatelessWidget {
  const SessionManagement({super.key, required this.sessionID});

  final String sessionID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorSessionListCubit>(
      create: (_) => DoctorSessionListCubit()..fetchSessionById(sessionID),
      child: SessionManagementView(sessionID: sessionID),
    );
  }
}

class SessionManagementView extends StatelessWidget {
  final String sessionID;

  const SessionManagementView({super.key, required this.sessionID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Session Feedback'),
      body: _SessionManagementBody(sessionID: sessionID),
    );
  }
}

class _SessionManagementBody extends StatefulWidget {
  final String sessionID;

  const _SessionManagementBody({required this.sessionID});

  @override
  State<_SessionManagementBody> createState() => _SessionManagementBodyState();
}

class _SessionManagementBodyState extends State<_SessionManagementBody> {
  final List<String> _comments = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final session = context.read<DoctorSessionListCubit>().selectedSession;
    if (session != null) {
      _comments.addAll(session.comments ?? []);
    }
  }

  @override
  void dispose() {
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

  Future<void> _addFeedback(BuildContext context) async {
    final cubit = context.read<DoctorSessionListCubit>();
    final text = await showDialog<String>(
      context: context,
      builder: (_) =>
          const FeedbackDialog(title: 'New Feedback', actionLabel: 'Add'),
    );

    if (text != null && text.isNotEmpty) {
      setState(() => _comments.add(text));
      await cubit.updateSessionComments(_comments, widget.sessionID);
      _scrollToBottom();
    }
  }

  Future<void> _editFeedback(BuildContext context, int index) async {
    final cubit = context.read<DoctorSessionListCubit>();
    final text = await showDialog<String>(
      context: context,
      builder: (_) => FeedbackDialog(
        title: 'Edit Feedback',
        initialText: _comments[index],
        actionLabel: 'Save',
      ),
    );

    if (text != null && text.isNotEmpty) {
      setState(() => _comments[index] = text);
      await cubit.updateSessionComments(_comments, widget.sessionID);
    }
  }

  Future<void> _deleteFeedback(BuildContext context, int index) async {
    final cubit = context.read<DoctorSessionListCubit>();
    final removed = _comments[index];

    setState(() => _comments.removeAt(index));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted: $removed'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.smRadius),
      ),
    );

    await cubit.updateSessionComments(_comments, widget.sessionID);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorSessionListCubit, GetDoctorSessionListStates>(
      listener: (context, state) {
        if (state is GetSpecificSessionSuccessStates) {
          final session = context
              .read<DoctorSessionListCubit>()
              .selectedSession;
          setState(() {
            _comments
              ..clear()
              ..addAll(session?.comments ?? []);
          });
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => _scrollToBottom(),
          );
        }

        if (state is UpdateDoctorSessionSuccessStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Feedback updated successfully'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is UpdateDoctorSessionFailedStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to update feedback'),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is GetSpecificSessionLoadingStates) {
          return const LoadingView(message: 'Loading session details...');
        }

        if (state is GetSpecificSessionFailedStates) {
          return ErrorView(
            message: 'Failed to load session feedback.',
            onRetry: () => context
                .read<DoctorSessionListCubit>()
                .fetchSessionById(widget.sessionID),
          );
        }

        if (_comments.isEmpty) {
          return Stack(
            children: [
              const EmptyView(
                title: 'No Feedback Yet',
                message:
                    'Start by adding your first feedback for this session.',
                icon: Icons.chat_bubble_outline_rounded,
              ),
              _buildFloatingActionButton(context),
            ],
          );
        }

        final session = context.read<DoctorSessionListCubit>().selectedSession;
        final date = session?.sessionDate;
        final timestamp = date != null
            ? DateFormat('MMM d, yyyy  hh:mm a').format(date)
            : '';

        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => context
                    .read<DoctorSessionListCubit>()
                    .fetchSessionById(widget.sessionID),
                color: AppColors.primary,
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _comments.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    return FeedbackCard(
                      comment: _comments[index],
                      timestamp: timestamp,
                      onEdit: () => _editFeedback(context, index),
                      onDelete: () => _deleteFeedback(context, index),
                    );
                  },
                ),
              ),
            ),
            _buildBottomAction(context),
          ],
        );
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Positioned(
      bottom: AppSpacing.xl,
      right: AppSpacing.lg,
      child: FloatingActionButton(
        onPressed: () => _addFeedback(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_rounded, color: AppColors.onPrimary),
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: AppButton(
          label: 'Add Feedback',
          icon: Icons.add_comment_rounded,
          onPressed: () => _addFeedback(context),
        ),
      ),
    );
  }
}
