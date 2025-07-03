import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Model/Appointmentbooked.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Screens/ConfirmReservationScreen.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/cubit/Booking/booking_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/cubit/Booking/booking_state.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/model/GetDoctorsListModel.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

enum PaymentMethod { cash, card }

class Paymenttype extends StatefulWidget {
  final Doctor CUR_Doctor;
  final BookSession sessionData;
  const Paymenttype(
      {super.key, required this.CUR_Doctor, required this.sessionData});

  @override
  _PaymenttypeState createState() => _PaymenttypeState();
}

class _PaymenttypeState extends State<Paymenttype> {
  PaymentMethod? _selectedMethod = PaymentMethod.cash;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCubit(),
      child: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is CancelBookingSuccess) Navigator.pop(context);

          

          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              leading: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: AppButtons.arrowbutton(() {
                  BookingCubit.get(context)
                      .CancelBooking(widget.sessionData.data!.sId ?? "");
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
                  // — your existing doctor info card —
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFCCDFFF),
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Leading image placeholder
                          Container(
                            child: Image.network(widget.CUR_Doctor.image ?? ""),
                            height: 80,
                            width: 75,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          SizedBox(width: 10),
                          // Info column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextUtils.textHeader(
                                    widget.CUR_Doctor.parent!.userName ?? ""),
                                SizedBox(height: 4),
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
                                SizedBox(height: 8),
                                TextUtils.textDescription(
                                  widget.CUR_Doctor.specialization ?? "",
                                  fontSize: 10,
                                  disTextColor: const Color(0xFF082F71),
                                ),
                                TextUtils.textDescription(
                                  "",
                                  fontSize: 10,
                                  disTextColor: const Color(0xFF082F71),
                                ),
                              ],
                            ),
                          ),
                          AppButtons.containerTextButton(
                            Text(
                              "Chat with doctor",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            ),
                            () {},
                            containerWidth: 100,
                            containerHeight: 30,
                          ),
                        ],
                      ),
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
                              if (_selectedMethod == PaymentMethod.card) {
                                BookingCubit.get(context)
                                    .generateStripePaymentSheet(
                                        widget.CUR_Doctor.id ?? "");
                              } else if (_selectedMethod ==
                                  PaymentMethod.cash) {
                                BookingCubit.get(context)
                                    .cashPayments(widget.CUR_Doctor.id ?? "");
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
                style: TextStyle(fontSize: 16, color: Color(0xFF082F71)),
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
