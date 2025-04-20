import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/colorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Paymentscheckscreen extends StatelessWidget {
  const Paymentscheckscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: AppButtons.arrowbutton(() => Navigator.pop(context)),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: TextUtils.textHeader("Payment Check",fontSize: 24),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
                      Container(
                        height: 80,
                        width: 75,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      // Content Column
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Title, rating & date row
                            TextUtils.textHeader("Doctor Name"),
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
                            const SizedBox(height: 5),
                            // Comment text
                            TextUtils.textDescription(
                              "Doctor’s department",
                              fontSize: 10,
                              disTextColor: const Color(0xFF082F71),
                            ),
                            TextUtils.textDescription(
                              "Address will be here.",
                              fontSize: 10,
                              disTextColor: const Color(0xFF082F71),
                            ),
                          ],
                        ),
                      ),
                      AppButtons.containerTextButton(
                          Text(
                            "Chat with doctor",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          () {},
                          containerWidth: 100,
                          containerHeight: 30),
                    ],
                  ),
                ),
              ),
                    TextUtils.textHeader("Payment Details",fontSize: 20),

              SizedBox(
                height: 370,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Appformtextfield(hintText: "Name",),
                    Appformtextfield(hintText: "Card Number"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: Appformtextfield(hintText: "Name")),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Appformtextfield(hintText: "Name")),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextUtils.textHeader("Date",
                                    fontSize: 16),
                                TextUtils.textHeader("XX / XX / XXXX",fontSize: 14)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextUtils.textHeader("Time", fontSize: 16),
                                TextUtils.textHeader("00:00 AM",fontSize: 14)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextUtils.textHeader("The price will be:", fontSize: 16),
                                TextUtils.textHeader("0.00 EGP",fontSize: 14)
                              ],
                            ),
                          ],

                        ),
                      ),
                    ),

                  ],
                ),
              ),
              AppButtons.containerTextButton(TextUtils.textHeader("Book Now",headerTextColor: Colors.white),(){}),
              
            ],
          ),
        ),
      ),
    );
  }
}
