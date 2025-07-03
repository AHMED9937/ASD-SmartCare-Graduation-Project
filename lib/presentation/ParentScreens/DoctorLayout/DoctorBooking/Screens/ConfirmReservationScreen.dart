import 'package:asdsmartcare/presentation/AsdAppLayouts/screens/ParentNavgationScreen.dart';
import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorsList/model/GetDoctorsListModel.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Confirmreservationscreen extends StatelessWidget {
 Doctor DoctorData;
   Confirmreservationscreen({super.key, required this.DoctorData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      toolbarHeight: 250,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      flexibleSpace:Container(
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
                      'Doctor Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Doctor Splications',
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
                          index < 2 ? Icons.star : Icons.star_border,
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
      body: Padding(
        padding:  EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 359,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                TextUtils.textHeader("Session price",fontSize: 24),
                TextUtils.textDescription("350 pounds")
              ],),
              Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                TextUtils.textHeader("Date",fontSize: 24),
                TextUtils.textDescription("01 Jul 2025")
              ],),
              Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                TextUtils.textHeader("Time",fontSize: 24),
                TextUtils.textDescription("09.00 Am")
              ],
              ),
              AppButtons.containerTextButton(TextUtils.textHeader("Done",headerTextColor: Colors.white),(){
                            Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (_) => ParentBottomNavgationScreen()),
  (Route<dynamic> route) => false,  // remove all previous routes
);


              }),

            ],
          ),),

        ],
        ),
      ),

    );
  }
}
