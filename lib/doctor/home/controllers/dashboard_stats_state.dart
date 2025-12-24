import 'package:equatable/equatable.dart';

abstract class DashboardStatsState extends Equatable {
  const DashboardStatsState();

  @override
  List<Object?> get props => [];
}

class DashboardStatsInitial extends DashboardStatsState {
  const DashboardStatsInitial();
}

class DashboardStatsLoading extends DashboardStatsState {
  const DashboardStatsLoading();
}

class DashboardStatsLoaded extends DashboardStatsState {
  final int appointmentsCount;
  final int patientsCount;
  final int sessionsCount;

  const DashboardStatsLoaded({
    required this.appointmentsCount,
    required this.patientsCount,
    required this.sessionsCount,
  });

  @override
  List<Object?> get props => [appointmentsCount, patientsCount, sessionsCount];
}

class DashboardStatsError extends DashboardStatsState {
  final String message;

  const DashboardStatsError(this.message);

  @override
  List<Object?> get props => [message];
}
