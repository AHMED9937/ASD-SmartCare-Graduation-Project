import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/screen/OTPVerificationScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/loginform.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:flutter/material.dart';

class Forgetpasswordscreen extends StatelessWidget {
  const Forgetpasswordscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppButtons.arrowbutton(() {
              Navigator.pop(context);
            }),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 346,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               
                  const SizedBox(
                    height: 67.5,
                  ),
                  TextUtils.textHeader("Forgot Password?",
                      fontSize: 36,
                      myfontFamily: 'Roboto',
                      myTextAlign: TextAlign.start),
                  const SizedBox(
                    height: 11,
                  ),
                  TextUtils.textDescription(
                    "Don’t worry! It occurs. Please enter the email address linked with your account.",
                    myfontFamily: 'Roboto',
                    fontSize: 12,
                    myTextAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const SizedBox(
                    width: 346,
                    child: Appformtextfield(
                      hintText: "Enter your email",
                      prefixIcon: Icon(
                        size: 24,
                        Icons.email_outlined,
                        color: Color(0xFF133E87),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            AppButtons.containerTextButton(
                TextUtils.textHeader(
                  "Send code",
                  headerTextColor: Colors.white,
                  myfontFamily: "Roboto",
                  fontSize: 20,
                ), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Otpverificationscreen(),
                  ));
            },
                containerColor: Color(0xFF25B9D3),
                containerWidth: 380,
                containerHeight: 57),
            const SizedBox(
              height: 26,
            ),
            const MyRichtext(
              Textdis: "Remember password? ",
              Textheader: "Log  in",
              navgaitto: Loginscreen(),
            ),
          ],
        ),
      ),
    );
  
  }
}
