import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_stats_state.dart';

class DashboardStatsCubit extends Cubit<DashboardStatsState> {
  DashboardStatsCubit() : super(const DashboardStatsInitial());

  static DashboardStatsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchDashboardStats() async {
    emit(const DashboardStatsLoading());

    try {
      final token = CacheHelper.getData(key: 'token');

      // We fetch all three data sets in parallel for efficiency
      final results = await Future.wait([
        Diohelper.getData(
          url: ApiConstants.GetDoctorAppointments,
          token: token,
        ),
        Diohelper.getData(
          url: ApiConstants.GetRegisteredChildrenList,
          token: token,
        ),
        Diohelper.getData(
          url: ApiConstants.GetDoctorSesstionList('coming'),
          token: token,
        ),
      ]);

      final appointmentsData = results[0].data;
      final patientsData = results[1].data;
      final sessionsData = results[2].data;

      // Calculate counts from responses
      // Appointments usually comes as { appointment: [...] } or { data: [...] }
      final appointments =
          (appointmentsData['appointment'] as List?)?.length ?? 0;

      // Patients refers to the total number of children registered under parents
      final parents = (patientsData['parents'] as List?) ?? [];
      int patientsCount = 0;
      for (final parent in parents) {
        patientsCount += (parent['childs'] as List?)?.length ?? 0;
      }

      // Sessions usually comes as { data: [...] }
      final sessionsCount = (sessionsData['data'] as List?)?.length ?? 0;

      emit(DashboardStatsLoaded(
        appointmentsCount: appointments,
        patientsCount: patientsCount,
        sessionsCount: sessionsCount,
      ));
    } catch (_) {
      emit(const DashboardStatsError('Failed to load dashboard statistics'));
    }
  }
}
