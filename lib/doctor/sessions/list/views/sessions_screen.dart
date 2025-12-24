import 'package:asdsmartcare/doctor/sessions/list/controllers/sessions_list_cubit.dart';
import 'package:asdsmartcare/doctor/sessions/list/controllers/sessions_list_state.dart';
import 'package:asdsmartcare/doctor/sessions/list/views/widgets/session_card.dart';
import 'package:asdsmartcare/doctor/sessions/list/views/widgets/session_details_sheet.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionsScreen extends StatelessWidget {
  final String status;

  const SessionsScreen({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorSessionListCubit()..fetchSessions(status: status),
      child: SessionsView(status: status),
    );
  }
}

class SessionsView extends StatelessWidget {
  final String status;

  const SessionsView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: '${status[0].toUpperCase()}${status.substring(1)} Sessions',
      ),
      body: _SessionsBody(status: status),
    );
  }
}

class _SessionsBody extends StatelessWidget {
  final String status;

  const _SessionsBody({required this.status});

  void _showDetails(BuildContext context, dynamic session) {
    final parent = session.parent!;
    final child = (parent.childs != null && parent.childs!.isNotEmpty)
        ? parent.childs!.first
        : null;

    if (child == null) return;

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
          return SessionDetailsSheet(
            parent: parent,
            child: child,
            session: session,
            scrollController: scrollController,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorSessionListCubit, GetDoctorSessionListStates>(
      builder: (context, state) {
        final cubit = DoctorSessionListCubit.get(context);

        if (state is GetDoctorSessionListLoadingStates) {
          return const LoadingView(message: 'Fetching sessions...');
        }

        if (state is GetDoctorSessionListFailedStates) {
          return ErrorView(
            message: 'We couldn\'t load your sessions. Please try again.',
            onRetry: () => cubit.fetchSessions(status: status),
          );
        }

        final sessions = cubit.sessions?.data;

        if (sessions == null || sessions.isEmpty) {
          return EmptyView(
            title: 'No $status sessions',
            message: 'You don\'t have any $status sessions at the moment.',
            icon: Icons.calendar_today_outlined,
          );
        }

        return RefreshIndicator(
          onRefresh: () => cubit.fetchSessions(status: status),
          color: AppColors.primary,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              final parent = session.parent!;
              final child = (parent.childs != null && parent.childs!.isNotEmpty)
                  ? parent.childs!.first
                  : null;

              return SessionCard(
                childName: child?.childName,
                age: child?.age,
                gender: child?.gender,
                date: session.createdAt,
                onTap: () => _showDetails(context, session),
              );
            },
          ),
        );
      },
    );
  }
}
