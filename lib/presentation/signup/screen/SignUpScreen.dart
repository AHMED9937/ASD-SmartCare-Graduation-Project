import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/screen/EmailVerfcationScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:asdsmartcare/presentation/signup/Widgets/signupform.dart';
import 'package:flutter/material.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,  // Ensures keyboard doesn't overlap content
      appBar: AppBar(
        leading: AppButtons.arrowbutton(() {
          Navigator.pop(context);
        }),
      ),
      body: SafeArea(  // Ensures UI is not clipped on devices with notches
        child: SingleChildScrollView(  // Makes content scrollable
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 14),
                TextUtils.textHeader("Sign up",
                    fontSize: 36, myfontFamily: 'Roboto'),
                TextUtils.textDescription(
                  "Create an account to use our service.",
                  myfontFamily: 'Roboto',
                  fontSize: 12,
                ),
                const SizedBox(height: 40),
                 signupform(),
                const SizedBox(height: 47),
                // the emile should not be in the data base the verfication code shold first know then if its right we do the sign in
                // "Next Step" Button
                AppButtons.containerTextButton(
                  TextUtils.textHeader(
                    "Next Step ",
                    headerTextColor: Colors.white,
                    myfontFamily: "Roboto",
                    fontSize: 20,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Emailverfcationscreen()),
                    );
                  },
                  containerColor: Color(0xFF25B9D3),
                ),
                const SizedBox(height: 26),
                // "Login" Link
                const MyRichtext(
                  navgaitto: Loginscreen(),
                  Textdis: "You have an account? ",
                  Textheader: " Login",
                ),
                const SizedBox(height: 20),  // Padding at the bottom for extra space
              ],
            ),
          ),
        ),
      ),
    );
  }
}
