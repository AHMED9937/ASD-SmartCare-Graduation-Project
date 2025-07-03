// booking_cubit.dart

import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Model/Appointmentbooked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart'; // <-- for formatting

import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  static BookingCubit get(context) => BlocProvider.of(context);

  String paymentIntent = "";
  String ephemeralKey = "";
  String customerId = "";
  String publishableKey = "";

  final Map<DateTime, List<String>> availableSlotsMap = {};
  BookSession? myAppoiment;

  /// Holds your slots organized by date.

  /// Call this with an optional `forDate` when you know which date these times apply to.
  /// Maps each normalized DateTime → list of slot-strings.

  /// Parses whichever “shape” your backend sends, grouping by date.
  /// If `forDate` is provided, it will be used for the simple list case.
  void loadSlotsFromJson(Map<String, dynamic> json, {DateTime? forDate}) {
    availableSlotsMap.clear();
    final raw = json['data'] as List<dynamic>? ?? [];
    if (raw.isEmpty) return;

    // Case A: ["5:00 AM", "6:00 AM", ...]
    if (raw.first is String) {
      final times = raw.cast<String>();
      final date = forDate ?? DateTime.now();
      final normalized = DateTime(date.year, date.month, date.day);
      availableSlotsMap[normalized] = times;
      return;
    }

    // Case B & C: list of maps
    for (final item in raw.cast<Map<String, dynamic>>()) {
      // parse date field
      final dateStr = item['date'] as String;
      DateTime parsed;
      try {
        parsed = DateTime.parse(dateStr);
      } catch (_) {
        final parts = dateStr.split('-');
        parsed = DateTime(
          int.parse(parts[0]),
          int.parse(parts[1]),
          int.parse(parts[2]),
        );
      }
      final normalized = DateTime(parsed.year, parsed.month, parsed.day);

      // handle both List<String> and String
      final timeField = item['time'];
      List<String> slotList;
      if (timeField is List) {
        slotList = timeField.cast<String>();
      } else if (timeField is String) {
        slotList = [timeField];
      } else {
        continue; // unexpected
      }

      // accumulate
      availableSlotsMap.putIfAbsent(normalized, () => []).addAll(slotList);
    }
  }

  void getDoctorsAppointments(
    String doctorId, {
    DateTime? onDate,
  }) {
    emit(LoadeDoctorAvailableDatesLoading());

    // If your API can filter by date, pass it as a query param:
    final query = <String, dynamic>{};
    if (onDate != null) {
      final fmt = '${onDate.year.toString().padLeft(4, '0')}-'
          '${onDate.month.toString().padLeft(2, '0')}-'
          '${onDate.day.toString().padLeft(2, '0')}';
      query['date'] = fmt;
    }

    Diohelper.getData(
      url: ApiConstants.GetAvailableApoimentForSpacificDoctor(doctorId),
      token: CacheHelper.getData(key: "token"),
    ).then((resp) {
      final json = resp.data as Map<String, dynamic>;
      loadSlotsFromJson(json, forDate: onDate);
      emit(LoadeDoctorAvailableDatesSuccess());
    }).catchError((e) {
      emit(LoadeDoctorAvailableDatesError(e.toString()));
    });
  }

  void bookWithDoctor({
    required String doctorId,
    required DateTime date,
    required String timeSlot,
  }) {
    // format date as yyyy-MM-dd
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    // weekday name, lowercase (e.g. "monday")
    final String dayName = DateFormat('EEEE').format(date).toLowerCase();
    print(doctorId);
    print(formattedDate);
    print(dayName);
    print(timeSlot);
    emit(BookingLoading());
    Diohelper.PostData(
      url: ApiConstants.BookAppointmentForSpecificDoctor(doctorId),
      token: CacheHelper.getData(key: "token"),
      data: {
        "date": formattedDate,
        "day": dayName,
        "time": timeSlot,
      },
    ).then((resp) {
      print(resp.data);
      myAppoiment = BookSession.fromJson(resp.data);

      emit(BookingSuccess(myAppoiment!));
    }).catchError((e) {
      emit(BookingError(e.toString()));
    });
  }

  List<String> getSlotsForDate(DateTime date) {
    final key = DateTime(date.year, date.month, date.day);
    return List.unmodifiable(availableSlotsMap[key] ?? []);
  }

  Set<DateTime> get selectableDates => availableSlotsMap.keys.toSet();

  void CancelBooking(String id) {
    emit(CancelBookingLoading());

    Diohelper.getData(
      url: ApiConstants.CancelBooking(
          id), // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      print(value.data);
      paymentIntent = value.data['paymentIntent'];
      ephemeralKey = value.data['ephemeralKey'];
      customerId = value.data['customer'];
      publishableKey = value.data['publishableKey'];
      //print(myDoctorList.data[0]);
      emit(CancelBookingSuccess());
    }).catchError((error) {
      print("Error fetching doctors list: $error");
      emit(CancelBookingError(error.toString()));
    });
  }

  Future<void> generateStripePaymentSheet(String appointmentId) async {
    print(appointmentId);
    emit(GenrateSPSLoading());
    try {
      // 1) Fetch Stripe secrets from your server
      final resp = await Diohelper.PostData(
        data: {},
        url: ApiConstants.GenrateSPS(appointmentId),
        token: CacheHelper.getData(key: "token"),
      );
      print(resp.data);
      final data = resp.data as Map<String, dynamic>;

      paymentIntent = data['paymentIntent'] as String;
      ephemeralKey = data['ephemeralKey'] as String;
      customerId = data['customer'] as String;
      publishableKey = data['publishableKey'] as String;

      // 2) Init Stripe SDK
      Stripe.publishableKey = publishableKey;
      await Stripe.instance.applySettings();

      // 4) Initialize the PaymentSheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent,
          customerEphemeralKeySecret: ephemeralKey,
          customerId: customerId,
          merchantDisplayName: 'Your Clinic Name',
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: 'EGP', // Egyptian pound
            currencyCode: 'EG', // ISO country code
            testEnv: true,
          ),
        ),
      );

      // 5) Present the sheet
      await Stripe.instance.presentPaymentSheet();
      emit(GenrateSPSSuccess());
    } on StripeException catch (e) {
      // a Stripe-specific error
      emit(GenrateSPSError(
          e.error.localizedMessage ?? 'Payment failed, please try again'));
    } catch (e) {
      // any other error (network, parsing, etc)
      emit(GenrateSPSError(e.toString()));
    }
  }

  void cashPayments(String id){
    
    emit(GenrateCSCOLoading());

    Diohelper.PostData(
      data: {"doctor":id},
      url: ApiConstants.CreateSessionCashOrder, // Ensure this matches your API endpoint key
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      print(value.data);
      emit(GenrateCSCOsuccess());
    }).catchError((error) {
      print("Error fetching doctors list: $error");
      emit(GenrateCSCOError(error.toString()));
    });
  }


}
