import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:flutter/material.dart';

class onBoardingScreen extends StatelessWidget {
  final String title;
  final String discrption;
  final String image_Link;


  const onBoardingScreen({super.key,required this.title,required this.discrption,required this.image_Link});


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children:[
          // Background Image with Specific Height
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              image_Link,
              fit: BoxFit.cover, // Adjust the scaling of the image
            ),
          ),
          // Positioned Button
          // Bottom Container with Description
          Positioned(
            top: 428, // Positioned below the image
            left: 0,
            right: 0,
            child: Container(
              height: 447,
              width: 428,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFFE7EBF4),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(41, 56, 41, 0),
                child: Column(
                  children: [
                    TextUtils.textHeader(
                      title,
                      fontSize: 24,
                    ),
                    SizedBox(height: 24,),
                    TextUtils.textDescription(
                      discrption,
                      fontSize: 18,
                    ),


                  ],),
              ),

            ),
          ),
          ],

      ),

    );
  }
}
