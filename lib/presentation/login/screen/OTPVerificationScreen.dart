import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/screen/CreatenewpasswordScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Otpverificationscreen extends StatelessWidget {
  const Otpverificationscreen({super.key});

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
              width: 337,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  const SizedBox(
                    height: 67.5,
                  ),
                  TextUtils.textHeader("OTP Verification?",
                      fontSize: 36,
                      myfontFamily: 'Roboto',
                      myTextAlign: TextAlign.start),
                  const SizedBox(
                    height: 11,
                  ),
                  TextUtils.textDescription(
                    "Enter the verification code we just sent on your email address",
                    myfontFamily: 'Roboto',
                    fontSize: 12,
                    my_FontWeight: FontWeight.w500,
                    myTextAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  OtpTextField(
                    fieldWidth: 60,
                    fieldHeight: 60,
                    numberOfFields: 4,
                    margin: EdgeInsets.only(
                      right: 24,
                    ),
                    contentPadding: EdgeInsets.all(20),
                    borderRadius: BorderRadius.circular(8),
                    keyboardType: TextInputType.number,
              
                    borderColor: Color(0xFF133E87),
              
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Verification Code"),
                              content:
                                  Text('Code entered is $verificationCode'),
                            );
                          });
                    }, // end onSubmit
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
                    builder: (context) => CreatenewpasswordScreen(),
                  ));
            },
                containerColor: Color(0xFF25B9D3),
                containerWidth: 380,
                containerHeight: 57),
            const SizedBox(
              height: 26,
            ),
            const MyRichtext(
              Textdis: "Don’t recieved code?  ",
              Textheader: "Resend code",
              navgaitto: Loginscreen(),
            ),
          ],
        ),
      ),
    );
  }
}
