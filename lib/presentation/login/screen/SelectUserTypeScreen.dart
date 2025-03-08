import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/screen/select_Login_or_SignUpScreen.dart';
import 'package:flutter/material.dart';

class Selectusertypescreen extends StatelessWidget {
   Selectusertypescreen({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          const SizedBox(
            height: 40,
          ),
          TextUtils.textHeader("Select user type!",
              fontSize: 36, myfontFamily: 'Roboto'),
          const SizedBox(
            height: 113,
          ),
          GestureDetector(
            onTap: () {
              CacheHelper.SaveData(key: "role", value:"Doctor" );

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectLoginOrSignupscreen(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(clipBehavior: Clip.none, children: [
                Container(
                  width: 388,
                  height: 108,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Color(0xFF67C8E4),
                  ),
                ),
                Positioned(
                  top: -75,
                  left: 29,
                  child: Image.asset(
                    'lib/appassets/images/doctor.png',
                    width: 125,
                    height: 183,
                  ),
                ),
                Positioned(
                  right: 75,
                  bottom: 33,
                  child: TextUtils.textHeader("Doctor",
                      fontSize: 36,
                      headerTextColor: Colors.white,
                      my_fontWeight: FontWeight.w600),
                ),
              ]),
            ),
          ),
                       SizedBox(height: 30,),
                       GestureDetector(
            onTap: () {
              CacheHelper.SaveData(key: "role", value:"parent" );

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectLoginOrSignupscreen(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(clipBehavior: Clip.none, children: [
                Container(
                  width: 388,
                  height: 108,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Color(0xFF67C8E4),
                  ),
                ),
                Positioned(
                  top: -17,
                  child: Image.asset(
                    'lib/appassets/images/parents.png',
                    width: 193,
                    height: 129,
                  ),
                ),
                Positioned(
                  right: 75,
                  bottom: 33,
                  child: TextUtils.textHeader("parent",
                      fontSize: 36,
                      headerTextColor: Colors.white,
                      my_fontWeight: FontWeight.w600),
                ),
              ]),
            ),
          ),
                       SizedBox(height: 30,),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
