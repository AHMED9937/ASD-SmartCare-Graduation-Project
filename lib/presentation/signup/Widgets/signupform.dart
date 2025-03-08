import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/screen/ForgetPasswordScreen.dart';
import 'package:flutter/material.dart';


class signupform extends StatelessWidget {
  
  final formkey = GlobalKey<FormState>();

  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child:const  SizedBox(
          width: 346,
          child: Column(
            children: [
              Appformtextfield(
                hintText: "Enter your User Name",
                prefixIcon: Icon(
                  size: 24,
                  Icons.edit,
                  color: Color(0xFF133E87),
                ),
              ),
               SizedBox(
                height: 20,
              ),
              Appformtextfield(
                hintText: "Enter your phone Number",
                prefixIcon: Icon(
                  size: 24,
                  Icons.phone,
                  color: Color(0xFF133E87),
                ),
              ),     
              SizedBox(
                height: 20,
              ),
              Appformtextfield(
                hintText: "Enter your email",
                prefixIcon: Icon(
                  size: 24,
                  Icons.email_outlined,
                  color: Color(0xFF133E87),
                ),
              ),     
              
               SizedBox(
                height: 20,
              ),
                Appformtextfield(
                hintText: "Enter your password",
                isObscureText: true,
                prefixIcon: Icon(
                  size: 24,
                  Icons.lock_outline,
                  color: Color(0xFF133E87),
                ),
              ),
            SizedBox(
                height: 20,
              ),
              Appformtextfield(
                hintText: "Confirm your password",
                isObscureText: true,
                prefixIcon: Icon(
                  size: 24,
                  Icons.lock_outline,
                  color: Color(0xFF133E87),
                ),
              ),
              SizedBox(
                height: 16,
              ),
             
            ],
          ),
        ));
  }
}
