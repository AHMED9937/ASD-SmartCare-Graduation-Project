import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/LoginCubits/Usercubit/login_cubit.dart';
import 'package:asdsmartcare/presentation/login/LoginCubits/Usercubit/login_state.dart';

import 'package:asdsmartcare/presentation/login/screen/ForgetPasswordScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



 String? emailValdation(value) {
    if (value == null || value.isEmpty)
     return "email cant be empty";
    return null;
  }
 String? passwordValdation(value) {
    if (value == null || value.isEmpty)
     return "Password cant be empty";
    return null;
  }
class Loginform extends StatefulWidget {
  Loginform({super.key});

  @override
  State<Loginform> createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLoginCubit, UserLoginState>(
      builder: (context, state) {
        return BlocConsumer<UserLoginCubit, UserLoginState>(
          listener: (context, state) {
            
          },
          builder: (context, state) {
            var login_cubit = UserLoginCubit.get(context);

            return Form(
                key: login_cubit.formKey,
                child: SizedBox(
                  height: 240,
                  width: 346,
                  child: Column(
                    children: [
                      Appformtextfield(
                        formValidator: emailValdation,
                        TextController: login_cubit.emailtextcontroller,
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
                        formValidator: passwordValdation,
                        TextController: login_cubit.passwordtextcontroller,
                        hintText: "Enter your password",
                       isObscureText: login_cubit.isObscureText,
                        prefixIcon: Icon(
                          size: 24,
                          Icons.lock_outline,
                          color: Color(0xFF133E87),
                        ),
                        suffixIcon: IconButton(onPressed: login_cubit.change_Password_visibilty, icon: login_cubit.visibility_icon),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                               Checkbox(
                           value: login_cubit.UserRememberMe,
                                 checkColor: Color(0xFF133E87),
                                 activeColor: Colors.white,
                               onChanged:login_cubit.RememberMefunc,
                               ),
                              TextUtils.textDescription("Remember Me",
                                  disTextColor: Color(0xFF133E87)),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          AppButtons.simpleTxtButton(
                              TextUtils.textDescription("Forgot Password?",
                                  disTextColor: Color(0xFF133E87)), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Forgetpasswordscreen(),
                                ));
                          })
                        ],
                      ),
                    ],
                  ),
                ));
          },
        );
      },
    );
  }
}
