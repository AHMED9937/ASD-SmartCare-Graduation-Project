import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/screen/EmailVerfcationScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/parentssignupform.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:flutter/material.dart';

class patentssignupscreen extends StatelessWidget {
  const patentssignupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,  // Ensures the keyboard doesn't overlap content
      appBar: AppBar(
        leading: AppButtons.arrowbutton(() {
          Navigator.pop(context);
        }),
      ),
      body: SafeArea(  // Wrap the entire body inside SafeArea to avoid clipping
        child: SingleChildScrollView(  // Make the entire content scrollable
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
                const parentssignupform(),
                const SizedBox(height: 47),
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
                      MaterialPageRoute(builder: (context) => Emailverfcationscreen())
                    );
                  },
                  containerColor: Color(0xFF25B9D3),
                ),
                const SizedBox(height: 26),
                const MyRichtext(
                  navgaitto: Loginscreen(),
                  Textdis: "You have an account? ",
                  Textheader: " Login",
                ),
                const SizedBox(height: 20),  // Add some padding to prevent any overflow when scrolling
              ],
            ),
          ),
        ),
      ),
    );
  }
}
