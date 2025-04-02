import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/screen/PasswordChangedscreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/loginform.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class CreatenewpasswordScreen extends StatelessWidget {
  const CreatenewpasswordScreen({super.key});

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
                  TextUtils.textHeader("Create new password",
                      fontSize: 33,
                      myfontFamily: 'Roboto',
                      myTextAlign: TextAlign.start),
                  const SizedBox(
                    height: 11,
                  ),
                  TextUtils.textDescription(
                    "Your new password must be unique from those previously used.",
                    myfontFamily: 'Roboto',
                    fontSize: 12,
                    my_FontWeight: FontWeight.w500,
                    myTextAlign: TextAlign.start,
              
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                 Appformtextfield(
              hintText: "New Password",
                            
                            ),
                            const SizedBox(
              height: 20,
                            ),
                             Appformtextfield(
              hintText: "Confirm Password",
              isObscureText: true,
                            ),
                           
                 
                ],
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            AppButtons.containerTextButton(
                TextUtils.textHeader(
                  "Reset Password",
                  headerTextColor: Colors.white,
                  myfontFamily: "Roboto",
                  fontSize: 20,
                ), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Passwordchangedscreen(),
                  ));
            },
                containerColor: Color(0xFF25B9D3),
                containerWidth: 358,
                containerHeight: 57),
          
          ],
        ),
      ),
    );
  }
}