import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/signupCubits/screen/EmailVerfcationScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:asdsmartcare/presentation/signupCubits/Widgets/signupform.dart';
import 'package:asdsmartcare/presentation/signupCubits/cubit/sign_up_cubit.dart';
import 'package:asdsmartcare/presentation/signupCubits/cubit/sign_up_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
          CacheHelper.SaveData(key: "token", value:state.lum.token );

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Emailverfcationscreen()),
            );
          } else if (state is SignUpErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                duration: Duration(seconds: 10),
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
                        fontSize: 12,
                      ),
                      const SizedBox(height: 40),
                      SignupForm(),
                      const SizedBox(height: 47),
                      ConditionalBuilder(
                        condition: state is! SignUpLoadingState,
                        builder: (context) => AppButtons.containerTextButton(
                          TextUtils.textHeader(
                            "Next Step ",
                            headerTextColor: Colors.white,
                            myfontFamily: "Roboto",
                            fontSize: 20,
                          ),
                          () {
                            SignUpCubit.get(context).userSignUp();
                          },
                          containerColor: const Color(0xFF25B9D3),
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(height: 26),
                      const MyRichtext(
                        navgaitto: Loginscreen(),
                        Textdis: "You have an account? ",
                        Textheader: " Login",
                      ),
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
