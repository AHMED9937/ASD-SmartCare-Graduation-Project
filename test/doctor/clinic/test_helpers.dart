import 'package:asdsmartcare/doctor/clinic/models/availability_model.dart';

class MockAvailabilityData {
  static Availability get sampleSlot => Availability(
        sId: '1',
        day: 'monday',
        date: '2023-12-25',
        time: '10:00 AM',
      );

  static GetDoctorAvailability get sampleResponse => GetDoctorAvailability(
        message: 'Success',
        data: [sampleSlot],
      );

  static GetDoctorAvailability get emptyResponse => GetDoctorAvailability(
        message: 'No availability found',
        data: [],
      );
}
