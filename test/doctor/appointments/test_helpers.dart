import 'package:asdsmartcare/doctor/appointments/models/appointment_model.dart';

class MockAppointmentData {
  static Appointment get sampleAppointment => Appointment(
        sId: '1',
        doctorId: 'doc1',
        date: '2023-12-25T10:00:00.000Z',
        day: 'Monday',
        time: '10:00 AM',
        status: 'booked',
      );

  static AppointmentsResponse get sampleResponse => AppointmentsResponse(
        message: 'Success',
        appointment: [sampleAppointment],
      );

  static AppointmentsResponse get emptyResponse => AppointmentsResponse(
        message: 'No appointments found',
        appointment: [],
      );
}
