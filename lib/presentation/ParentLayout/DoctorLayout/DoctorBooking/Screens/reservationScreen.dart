import 'package:asdsmartcare/appShared/remote/diohelper.dart';
import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/Chat/screen/Chat.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorBooking/Screens/PaymentType.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorBooking/Widgets/doctorReviews.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorsList/model/GetDoctorsListModel.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorBooking/cubit/Booking/booking_cubit.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorBooking/cubit/Booking/booking_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Reservationscreen extends StatefulWidget {
  final Doctor myDoctor;
  const Reservationscreen({Key? key, required this.myDoctor}) : super(key: key);

  @override
  State<Reservationscreen> createState() => _ReservationscreenState();
}

class _ReservationscreenState extends State<Reservationscreen> {
  late DateTime _selectedDate;
  String? _selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final toolbarHeight = media.height * 0.25; // 25% of screen height
    final horizontalPadding = media.width * 0.04; // 4% of screen width
    final verticalPadding = media.height * 0.02; // 2% of screen height

    return BlocProvider(
      create: (_) =>
          BookingCubit()..getDoctorsAppointments(widget.myDoctor.id ?? ""),
      child: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Paymenttype(
                  CUR_Doctor: widget.myDoctor,
                  sessionData: state.AppoimentData,
                ),
              ),
            );
          }
          if (state is BookingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = BookingCubit.get(context);

          if (state is LoadeDoctorAvailableDatesLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is LoadeDoctorAvailableDatesError) {
            return Scaffold(
              body: Center(
                child: Text(
                  "Sorry No available Appoiments",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          final sortedDates = cubit.selectableDates.toList()..sort();
          if (sortedDates.isEmpty) {
            return Scaffold(
              appBar: AppBarWithText(context, "No Appointments"),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_today,
                          size: 72, color: Colors.grey[400]),
                      const SizedBox(height: 24),
                      Text(
                        'No Available Appointment Dates',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Please check back later or select a different doctor.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () =>
                            cubit.getDoctorsAppointments(widget.myDoctor.id!),
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Retry',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF133E87),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final effectiveDate = sortedDates.contains(_selectedDate)
              ? _selectedDate
              : sortedDates.first;
          final slotsForDate = cubit.getSlotsForDate(effectiveDate);

          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: ConditionalBuilder(
              condition: state is! BookingLoading,
              builder: (_) {
                final width = MediaQuery.of(context).size.width * 0.9;
                return AppButtons.containerTextButton(
                  // constrain height & width
                  containerHeight: 50,
                  containerWidth: width-20,
                  TextUtils.textHeader(
                    "Book Now",
                    headerTextColor: Colors.white,
                  ),
                  () {
                    final bookingDate = sortedDates.contains(_selectedDate)
                        ? _selectedDate
                        : sortedDates.first;
                    if (_selectedTimeSlot == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a time slot."),
                        ),
                      );
                      return;
                    }
                    cubit.bookWithDoctor(
                      doctorId: widget.myDoctor.id!,
                      date: bookingDate,
                      timeSlot: _selectedTimeSlot!,
                    );
                  },
                  containerColor: const Color(0xFF133E87),
                );
              },
              fallback: (_) => Align(
                alignment: Alignment.bottomCenter,
                child: const CircularProgressIndicator(),
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              toolbarHeight: toolbarHeight,
              flexibleSpace: _buildDoctorHeader(widget.myDoctor, toolbarHeight),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Choose Your Date",
                    style: TextStyle(
                      color: Color(0xFF133E87),
                      fontSize: media.width * 0.06, // 6% of screen width
                    ),
                  ),
                  SizedBox(height: verticalPadding),
                  CalendarTimeline(
                    initialDate: effectiveDate,
                    firstDate: sortedDates.first,
                    lastDate: DateTime.now().add(Duration(days: 365 * 4)),
                    onDateSelected: (date) {
                      setState(() {
                        _selectedDate =
                            DateTime(date.year, date.month, date.day);
                        _selectedTimeSlot = null;
                      });
                    },
                    monthColor: const Color(0xFF133E87),
                    dayColor: Colors.grey,
                    dayNameColor: Colors.black,
                    activeDayColor: Colors.white,
                    activeBackgroundDayColor: const Color(0xFF133E87),
                    dotColor: Colors.black,
                    locale: 'en',
                    selectableDayPredicate: (date) {
                      final d = DateTime(date.year, date.month, date.day);
                      return cubit.selectableDates.contains(d);
                    },
                    // reduced from 15% to 12% of screen height
                    height: media.height * 0.1,
                  ),
                  SizedBox(
                      height: verticalPadding * 0.8), // slightly less spacing
                  Expanded(
                    child: slotsForDate.isEmpty
                        ? Center(
                            child: Text(
                              "No available times.",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: media.width * 0.035),
                            ),
                          )
                        : GridView.count(
                            // keep it compact
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            crossAxisSpacing: media.width * 0.015,
                            mainAxisSpacing: media.height * 0.015,
                            childAspectRatio: 2,
                            children: slotsForDate.map((time) {
                              final isSelected = _selectedTimeSlot == time;
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isSelected
                                      ? const Color(0xFF133E87)
                                      : const Color(0xFFEEEEEE),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: media.height * 0.01,
                                    horizontal: media.width * 0.01,
                                  ),
                                ),
                                onPressed: () => setState(() =>
                                    _selectedTimeSlot =
                                        isSelected ? null : time),
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF133E87),
                                    fontSize: media.width *
                                        0.035, // slightly smaller text
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                  SizedBox(height: verticalPadding),
                  TextUtils.textHeader("Reviews!",
                      fontSize: media.width * 0.05),
                  Expanded(
                    flex: 2,
                    child: ReviewListView(
                      ID: widget.myDoctor.id ?? "",
                      showAllReviews: true,
                    ),
                  ),
                  SizedBox(height: verticalPadding),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDoctorHeader(Doctor doc, toolbarHeight) {
    return Container(
      height: toolbarHeight,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF133E87), Color(0xFF0C2C5D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(170),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: doc.image != null
                  ? Image.network(doc.image!,
                      width: 88, height: 88, fit: BoxFit.contain)
                  : Icon(Icons.person, size: 60, color: Colors.grey.shade400),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  doc.parent?.userName ?? "Unknown Doctor",
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doc.speciailization ?? "General",
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
                const SizedBox(height: 12),
                RatingBarIndicator(
                  rating: (doc.ratingsAverage ?? 0).toDouble(),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 16,
                  unratedColor: Colors.white54,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
