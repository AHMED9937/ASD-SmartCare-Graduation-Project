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
       body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 77,
                ),
                Image.asset(
                  'lib/appassets/images/Group22.png',
                  width: 166,
                  height: 166,
                ),
                SizedBox(
                  height: 55,
                ),
                SizedBox(
                  width: 322,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextUtils.textHeader("password Changed!",
                          fontSize: 33, myfontFamily: 'Roboto'),
                      TextUtils.textDescription(
                        "Your  password been changed successfully.",
                        myfontFamily: 'Roboto',
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                AppButtons.containerTextButton(
                  TextUtils.textHeader(
                    "Back to Login",
                    headerTextColor: Colors.white,
                    myfontFamily: "Roboto",
                    fontSize: 20,
                  ),
                  () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Loginscreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
                const SizedBox(
                  height: 26,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
