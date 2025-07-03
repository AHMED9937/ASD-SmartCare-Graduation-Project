import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/AsdAppLayouts/screens/ParentNavgationScreen.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Testresult extends StatelessWidget {
  final bool isFirstTest;
  const Testresult({super.key, required this.isFirstTest});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        actions: [],
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextUtils.textHeader("Autism Test result",
                  fontSize: 24, headerTextColor: Color(0xFF082F71)),
              Image.asset(
                  height: 40, width: 40, "lib/appassets/images/autism.png")
            ],
          ),
        ),
      ),
      body: RecentTest(isFirstTest: isFirstTest,BackToHomeButton: true,),
    );
  }
}

class RecentTest extends StatelessWidget {
   RecentTest({
    super.key,
    required this.isFirstTest,
    required this.BackToHomeButton,
  });

  final bool isFirstTest;
  final bool BackToHomeButton;

  final List<Map<String, String>> doctors = [
    {
      "name": "Dr.Ahmed ",
      "specialty": " child psychiatrist ",
      "image": "lib/appassets/images/doctor1.png",
      "Address":"alsharqiya "


    },
    {
      "name": "Dr.Omnia",
      "specialty": "psychologist",
      "image": "lib/appassets/images/doctor2.png",
      "Address":"Aswan "

    },
    {
      "name": "Dr.Muhammad",
      "specialty": "pediatric neurologist,",
      "image": "lib/appassets/images/doctor3.png",
      "Address":"ismailia "

    },
    {
      "name": "Dr.Samir",
      "specialty": "developmental pediatrician",
      "image": "lib/appassets/images/doctor4.png",
      "Address":"cairo"
    }
  ];

 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          isFirstTest
              ? Center(
                child: TextUtils.textHeader(
                    CacheHelper.getData(key: "autism_prediction") == "1"
                        ? "You may have Autism Spectrum Disorder"
                        : "You are unlikely to have Autism Spectrum Disorder"),
              )
              : asdR(),
          TextUtils.textHeader("Some Notes", fontSize: 16),
          SizedBox(
              height: 142,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: TextUtils.textDescription(index==0?"Begin early intervention immediately.":index==1?"Book doctor appointment today.":"Join parent support group."),
                ),
              )),
        BackToHomeButton?  AppButtons.containerTextButton(
              TextUtils.textHeader("Back To Home Screen ",
                  headerTextColor: Colors.white), () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => ParentBottomNavgationScreen()),
              (_) => false, // removes all existing routes
            );
          }):Text(""),
        BackToHomeButton?   TextUtils.textHeader("Recommended  Doctors for your level:",
              fontSize: 16):Text(""),
        BackToHomeButton?  SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: doctors.length,
              padding: EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
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
                        child: doctors[index]["image"]!=null?Image.asset(doctors[index]["image"]!):null,
                        height: 80,
                        width: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            
                            ),
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
                            TextUtils.textHeader(doctors[index]["name"]!),
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
                              doctors[index]["specialty"]!,
                              fontSize: 10,
                              disTextColor: const Color(0xFF082F71),
                            ),
                            TextUtils.textDescription(
                              doctors[index]["Address"]!,
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
              ),
            ),
          ):Text(""),
        ],
      ),
    );
  }
}
