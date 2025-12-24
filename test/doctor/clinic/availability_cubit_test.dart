import 'package:asdsmartcare/doctor/clinic/controllers/clinic_cubit.dart';
import 'package:asdsmartcare/doctor/clinic/controllers/clinic_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AvailabilityCubit', () {
    late AvailabilityCubit cubit;

    setUp(() {
      cubit = AvailabilityCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is AvailabilityInitial', () {
      expect(cubit.state, isA<AvailabilityInitial>());
    });
  });
}
