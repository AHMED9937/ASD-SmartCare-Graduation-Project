import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorBooking/Model/Appointmentbooked.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorBooking/Screens/ConfirmReservationScreen.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorBooking/cubit/Booking/booking_cubit.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorBooking/cubit/Booking/booking_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/DoctorLayout/DoctorsList/model/GetDoctorsListModel.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

enum PaymentMethod { cash, card }

class Paymenttype extends StatefulWidget {
  final Doctor CUR_Doctor;
  final BookSession sessionData;
  const Paymenttype({
    super.key,
    required this.CUR_Doctor,
    required this.sessionData,
  });

  @override
  _PaymenttypeState createState() => _PaymenttypeState();
}

class _PaymenttypeState extends State<Paymenttype> {
  PaymentMethod? _selectedMethod = PaymentMethod.cash;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingCubit(),
      child: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is CancelBookingSuccess) {
            Navigator.pop(context);
          }

          if (state is GenrateSPSSuccess || state is GenrateCSCOsuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => Confirmreservationscreen(
                  DoctorData: widget.CUR_Doctor,
                  sessionD: widget.sessionData,
                ),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              leading: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: AppButtons.arrowbutton(() {
                  // Use safe navigation and default to empty ID if null
                  final sessionId = widget.sessionData.data?.sId ?? "";
                  BookingCubit.get(context).CancelBooking(sessionId);
                }),
              ),
              centerTitle: true,
              toolbarHeight: 80,
              title: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextUtils.textHeader("Payment Check", fontSize: 24),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // — updated doctor info card —
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Leading image placeholder
                        ClipOval(
                          child: widget.CUR_Doctor.image != null &&
                                  widget.CUR_Doctor.image!.isNotEmpty
                              ? Image.network(
                                  widget.CUR_Doctor.image!,
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.cover,
                                  width: 72,
                                  height: 72,
                                  errorBuilder: (_, __, ___) =>
                                      Icon(Icons.person,
                                          size: 36,
                                          color: Colors.grey.shade600),
                                )
                              : Container(
                                  color: Colors.grey.shade200,
                                  width: 72,
                                  height: 72,
                                  child: Icon(Icons.person,
                                      size: 36,
                                      color: Colors.grey.shade600),
                                ),
                        ),
                        SizedBox(width: 16),
                        // Info column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextUtils.textHeader(
                                // Safe navigation on parent and default to empty
                                widget.CUR_Doctor.parent?.userName ?? "",
                                fontSize: 14,
                              ),
                              SizedBox(height: 6),
                              RatingBarIndicator(
                                // Default to 0.0 if null
                                rating: (widget.CUR_Doctor.ratingsAverage ?? 0)
                                    .toDouble(),
                                itemCount: 5,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                                itemSize: 14,
                                direction: Axis.horizontal,
                              ),
                              SizedBox(height: 10),
                             
                            ],
                          ),
                        ), ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // — Payment method selector —
                  TextUtils.textHeader("Payment Method", fontSize: 18),
                  SizedBox(height: 24),

                  _buildOption(
                    icon: Icons.attach_money,
                    label: 'Cash payment at the clinic',
                    value: PaymentMethod.cash,
                  ),
                  SizedBox(height: 12),
                  _buildOption(
                    icon: Icons.credit_card,
                    label: 'Credit Card or E-wallet',
                    value: PaymentMethod.card,
                  ),

                  SizedBox(height: 48),

                  // — Continue button —
                  SizedBox(
                    width: 275,
                    child: ElevatedButton(
                      onPressed: _selectedMethod == null
                          ? null
                          : () {
                              // Default to empty string if id is null
                              final doctorId = widget.CUR_Doctor.id ?? "";
                              if (_selectedMethod == PaymentMethod.card) {
                                BookingCubit.get(context)
                                    .generateStripePaymentSheet(doctorId);
                              } else {
                                BookingCubit.get(context)
                                    .cashPayments(doctorId);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF133E87),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required PaymentMethod value,
  }) {
    final isSelected = _selectedMethod == value;
    return InkWell(
      onTap: () => setState(() => _selectedMethod = value),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF082F71)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF082F71)),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 15, color: Color(0xFF082F71)),
              ),
            ),
            Radio<PaymentMethod>(
              value: value,
              groupValue: _selectedMethod,
              activeColor: Color(0xFF082F71),
              onChanged: (newVal) => setState(() => _selectedMethod = newVal),
            ),
          ],
        ),
      ),
    );
  }
}
