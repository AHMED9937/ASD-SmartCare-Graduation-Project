
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/SignUp/screen/EmailVerfcationScreen.dart';

import 'package:asdsmartcare/presentation/SignUp/Widgets/ParentSignUpForm.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/Parentcubit/parent_sign_up_cubit.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/Parentcubit/parent_sign_up_state.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentSignUpScreen extends StatelessWidget {
  const ParentSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentSignUpCubit(),
      child: BlocConsumer<ParentSignUpCubit, ParentSignUpState>(
        listener: (context, state) {
          if (state is ParentSignUpSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Text("Succsess"),
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Emailverfcationscreen(parentID:  state.lum.data.id ,ParentUserName:  state.lum.data.userName,)),
              
            );
          } else if (state is ParentSignUpErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: AppButtons.arrowbutton(() {
                Navigator.pop(context);
              }),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 14),
                      TextUtils.textHeader("Sign up",
                          fontSize: 36, myfontFamily: 'Roboto'),
                      TextUtils.textDescription(
                          "Create an account to use our service.",
                          myfontFamily: 'Roboto',
                          fontSize: 12),
                      const SizedBox(height: 40),
                      Parentsignupform(), // Make sure this form is correctly set up with the SignUpCubit
                      const SizedBox(height: 47),
                      ConditionalBuilder(
                        condition: state is! ParentSignUpLoadingState,
                        builder: (context) => AppButtons.containerTextButton(
                          TextUtils.textHeader("Next Step ",
                              headerTextColor: Colors.white,
                              myfontFamily: "Roboto",
                              fontSize: 20),
                          () {
                            
                            ParentSignUpCubit.get(context).ParentSignUp();
                          },
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                       const SizedBox(height: 26),
                      const MyRichtext(
                          navgaitto: Loginscreen(),
                          Textdis: "You have an account? ",
                          Textheader: " Login"),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
