import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/loginform.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:flutter/material.dart';

class Passwordchangedscreen extends StatelessWidget {
  const Passwordchangedscreen({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
         appBar: AppBar(
        leading: AppButtons.arrowbutton(() {
              Navigator.pop(context);
            }),
      ),
     
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Center(
            child: Column(
              children: [
                const SizedBox(height: 77,),
         
                Image.asset(
                  'lib/appassets/images/Group22.png',
                  width: 166,
                  height: 166,
                ),
                SizedBox(height: 55,),
                 SizedBox(
                  width: 322,
                  height: 89,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextUtils.textHeader("password Changed!",
                          fontSize: 36, myfontFamily: 'Roboto'),
                      TextUtils.textDescription(
                        "Your  password been changed successfully.",
                        myfontFamily: 'Roboto',
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24,),
                AppButtons.containerTextButton(TextUtils.textHeader("Log in",headerTextColor: Colors.white,myfontFamily: "Roboto",fontSize: 20,), (){},containerColor: Color(0xFF25B9D3)),
                const SizedBox(height: 26,),
              
              
              
              ],
            ),
          ),
        ],
      ),
    );
  
  }
}