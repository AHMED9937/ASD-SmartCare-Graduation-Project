import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Screens/ConfirmReservationScreen.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/cubit/Booking/booking_state.dart';
import 'package:asdsmartcare/presentation/CharityAndDonations/Screen/availlableCharityMed.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:asdsmartcare/presentation/ParentScreens/apphome/AvailableMedicine/Screen/AvailableMedicineScreen.dart';
import 'package:asdsmartcare/presentation/CharityAndDonations/Model/CharityResponse.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/cubit/Booking/booking_cubit.dart';

enum CharityPaymentMethod { cash, card }

class CharityInfo extends StatefulWidget {
  final Charity charityData;
  const CharityInfo({Key? key, required this.charityData}) : super(key: key);

  @override
  _CharityInfoState createState() => _CharityInfoState();
}

class _CharityInfoState extends State<CharityInfo> {
  CharityPaymentMethod _selectedMethod = CharityPaymentMethod.cash;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingCubit(),
      child: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is GenrateSPSSuccess)
      ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    backgroundColor: Colors.green.shade600,
    content: Text(
      '🎉 Donation successful!\nThank you for your generosity.',
      style: TextStyle(color: Colors.white),
    ),
    duration: Duration(seconds: 6),
  ),
);    if (state is GenrateCSCOsuccess)
      ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    backgroundColor: Colors.green.shade600,
    content: Text(
      '🎉 Donation Confirmed!\nThank you for your generosity. Please visit the charity office to complete your cash payment.',
      style: TextStyle(color: Colors.white),
    ),
    duration: Duration(seconds: 6),
  ),
);

          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarWithText(context, "Charity Info"),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 11,
                  ),
                  // Header Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    color: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: (widget.charityData.logo != null)
                                ? Image.network(
                                    widget.charityData.logo!,
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 64,
                                    height: 64,
                                    color: Colors.grey[300],
                                  ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.charityData.charityName ??
                                      'Unknown Charity',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                RatingBarIndicator(
                                  rating: 0,
                                  itemCount: 5,
                                  itemSize: 16,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (_, __) =>
                                      Icon(Icons.star, color: Colors.amber),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.charityData.charityAddress ?? '',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.indigo.shade700),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.charityData.charityPhone ?? '',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.indigo.shade700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon:
                              Icon(Icons.phone, color: Colors.indigo.shade700),
                          label: Text('Contact'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.indigo.shade700),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            // TODO: implement contact
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon:
                              Icon(Icons.medical_services, color: Colors.white),
                          label: Text('Medicines',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AvaillableCharityMed(medicines: widget.charityData.charityMedican??[],)),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                  Text(
                    'Donation Method',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade800),
                  ),
                  const SizedBox(height: 16),

                  // Custom Payment Options
                  _buildOption(
                    icon: Icons.credit_card,
                    label: 'Credit Card / E-wallet',
                    value: CharityPaymentMethod.card,
                  ),
                  const SizedBox(height: 20),
                  _buildOption(
                    icon: Icons.money,
                    label: 'Cash at Charity',
                    value: CharityPaymentMethod.cash,
                  ),

                  const SizedBox(height: 64),

                  // Donate Button
                  ConditionalBuilder(
                    condition: state is !GenrateSPSLoading || state is !GenrateCSCOLoading,
                    builder:(_)=> ElevatedButton(
                      onPressed: () {
                        final id = "68502150d29361dcad110270";
                        if (_selectedMethod == CharityPaymentMethod.card) {
                          context
                              .read<BookingCubit>()
                              .generateStripePaymentSheet(id);
                        } else {
                          context.read<BookingCubit>().cashPayments(id);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Donate Now!',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  fallback: (_)=>Center(child: CircularProgressIndicator(),),
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
    required CharityPaymentMethod value,
  }) {
    final isSelected = _selectedMethod == value;
    return InkWell(
      onTap: () => setState(() => _selectedMethod = value),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.indigo.shade700),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.grey.shade100 : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.indigo.shade700),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 16, color: Colors.indigo.shade700),
              ),
            ),
            Radio<CharityPaymentMethod>(
              value: value,
              groupValue: _selectedMethod,
              activeColor: Colors.indigo.shade700,
              onChanged: (newVal) => setState(() => _selectedMethod = newVal!),
            ),
          ],
        ),
      ),
    );
  }
}
