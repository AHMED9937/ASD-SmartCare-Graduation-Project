import 'package:asdsmartcare/presentation/AfterLoginRootes/DoctorLayout/DoctorsList/model/GetDoctorsListModel.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Reservationscreen extends StatefulWidget {
  DoctorModel? myDoctor;

  Reservationscreen({Key? key, required DoctorModel? myDoctor})
      : myDoctor = myDoctor, // assign the parameter to the field
        super(key: key);
  @override
  State<Reservationscreen> createState() => _Reservationscreen();
}

class _Reservationscreen extends State<Reservationscreen> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  // Variable to track the currently selected time slot
  String? _selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
    _selectedTime = TimeOfDay.now();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 2));
  }

  // Function to update the selected time from time slots
  void _selectTime(String time) {
    setState(() {
      _selectedTime = _convertToTimeOfDay(time);
    });
  }

  // Helper function to convert a time string to TimeOfDay
  TimeOfDay _convertToTimeOfDay(String time) {
    final parts = time.split(" ");
    final hourMinute = parts[0].split(":");
    int hour = int.parse(hourMinute[0]);
    final minute = int.parse(hourMinute[1]);

    if (parts[1].toLowerCase() == "pm" && hour != 12) {
      hour += 12;
    } else if (parts[1].toLowerCase() == "am" && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  // Function to show the time picker and update _selectedTime
  Future<void> _selectTimePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 250,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        flexibleSpace:    Container(
            height: 250,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 58, left: 17),
            decoration: const BoxDecoration(
              color: Color(0xFF133E87),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(170),
              ),
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    margin: const EdgeInsets.all(8),
                    shadowColor: const Color.fromARGB(255, 183, 201, 233),
                    elevation: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    
                      child: Image.asset(
                        'lib/appassets/images/doctor1.png',
                        height: 99,
                        width: 88,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Doctor Info Column
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.myDoctor!.user!.userName}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${widget.myDoctor!.specialization}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Star Rating
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < widget.myDoctor!.ratingQuantity ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: AppButtons.containerTextButton(
                            TextUtils.textHeader(
                              "Chat with doctor",
                              fontSize: 15,
                              headerTextColor: Color(0xFF133E87),
                            ),
                            () {},
                            containerHeight: 27,
                            containerWidth: 144,
                            containerColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
       
      ),
      backgroundColor: Colors.white,
      // Use a Column with fixed top content and an Expanded review section.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Doctor Info Section (mimicking the flexible AppBar)
            // Date & Calendar Timeline Section
            const Text(
              "Choose Your Date",
              style: TextStyle(
                color: Color(0xFF133E87),
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            CalendarTimeline(
              initialDate: _selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
              onDateSelected: (date) => setState(() => _selectedDate = date),
              monthColor: const Color(0xFF133E87),
              dayColor: const Color(0xFF133E87),
              dayNameColor: Colors.black,
              activeDayColor: Colors.black,
              shrink: false,
              activeBackgroundDayColor: const Color(0xFFCCDFFF),
              dotColor: Colors.black,
              selectableDayPredicate: (date) => date.day != 23,
              locale: 'en',
            ),
            const SizedBox(height: 30),
            // Time Slots Grid
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildTimeSlot('09:00 AM'),
                _buildTimeSlot('12:00 PM'),
                _buildTimeSlot('02:00 PM'),
                _buildTimeSlot('07:00 PM'),
                _buildTimeSlot('08:00 PM'),
                _buildTimeSlot('11:00 PM'),
              ],
            ),
            const SizedBox(height: 5),
            // Book Now button
            AppButtons.containerTextButton(
              TextUtils.textHeader("Book Now", headerTextColor: Colors.white),
              () {},
            ),
            const SizedBox(height: 5),
            // Review Section - Converted from ListTile to Container without padding
           
           if ( widget.myDoctor!.ratingQuantity==0)
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return  Container(
                    
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7EBF4),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Leading image container (placeholder)
                          CircleAvatar(backgroundColor: Colors.white,),
                          // Content Column
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title, rating & date row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextUtils.textHeader("Customer’s Name"),
                                    RatingBarIndicator(
                                      rating: 2.0,
                                      itemCount: 5,
                                      itemBuilder: (context, index) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemSize: 12,
                                      direction: Axis.horizontal,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "5 days ago",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                // Comment text
                                TextUtils.textDescription(
                                  "${_selectedDate}",
                                  fontSize: 10,
                                  disTextColor: const Color(0xFF082F71),
                                ),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Updated time slot builder function with toggle logic
  Widget _buildTimeSlot(String time) {
    final bool isSelected = _selectedTimeSlot == time;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFFCCDFFF) : const Color(0xFFEEEEEE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        setState(() {
          if (_selectedTimeSlot == time) {
            _selectedTimeSlot = null;
          } else {
            _selectedTimeSlot = time;
            _selectTime(time);
          }
        });
      },
      child: Text(
        time,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF133E87),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
