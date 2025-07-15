import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/LoginCubits/Usercubit/login_cubit.dart';

import 'package:asdsmartcare/presentation/login/ForgetPassword/Screens/ForgetPasswordScreen.dart';
import 'package:flutter/material.dart';

String? emailValdation(value) {
  if (value == null || value.isEmpty) return "email cant be empty";
  return null;
}

String? passwordValdation(value) {
  if (value == null || value.isEmpty) return "Password cant be empty";
  return null;
}

// ignore: must_be_immutable
class Loginform extends StatefulWidget {
  Loginform({super.key});

  @override
  State<Loginform> createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    final login_cubit = UserLoginCubit.get(context);

    return Form(
        key: login_cubit.formKey,
        child: Column(
          children: [
            Appformtextfield(
              formValidator: emailValdation,
              TextController: login_cubit.emailController,
              hintText: "Enter your email",
              prefixIcon:const Icon(
                size: 24,
                Icons.email_outlined,
                color: Color(0xFF133E87),
              ),
            ),
          const  SizedBox(
              height: 20,
            ),
            Appformtextfield(
              formValidator: passwordValdation,
              TextController: login_cubit.passwordController,
              hintText: "Enter your password",
              isObscureText: login_cubit.isObscureText,
              prefixIcon:const Icon(
                size: 24,
                Icons.lock_outline,
                color: Color(0xFF133E87),
              ),
              suffixIcon: IconButton(
                  onPressed: login_cubit.changePasswordVisibility,
                  icon: login_cubit.visibilityIcon),
            ),
           const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: login_cubit.userRememberMe,
                      checkColor:const Color(0xFF133E87),
                      activeColor: Colors.white,
                      onChanged: login_cubit.rememberMeFunc,
                    ),
                    TextUtils.textDescription("Remember Me",
                        disTextColor:const Color(0xFF133E87),fontSize: 13),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),
                AppButtons.simpleTxtButton(
                    TextUtils.textDescription("Forgot Password?",fontSize: 13,
                        disTextColor:const Color(0xFF133E87)), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Forgetpasswordscreen(),
                      ));
                })
              ],
            ),
          ],
        ));
  }
}
