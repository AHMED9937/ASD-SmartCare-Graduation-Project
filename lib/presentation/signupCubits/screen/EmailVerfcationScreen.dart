import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/screen/CreatenewpasswordScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/SelectusertypeScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:asdsmartcare/presentation/signupCubits/cubit/sign_up_cubit.dart';
import 'package:asdsmartcare/presentation/signupCubits/cubit/sign_up_state.dart';
import 'package:asdsmartcare/presentation/signupCubits/screen/DoctorSignUpScreen.dart';
import 'package:asdsmartcare/presentation/signupCubits/screen/ParentSignUpScreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Emailverfcationscreen extends StatelessWidget {
  const Emailverfcationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpresetCodeSuccessState) {
            // Delay to show dialog after the frame is built
            Future.delayed(Duration.zero, () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'lib/appassets/images/Group22.png',
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        TextUtils.textHeader("Verified!", fontSize: 24),
                        TextUtils.textDescription(
                            "Yahoo!  You have successfully verified the account. ",
                            fontSize: 12),
                        const SizedBox(
                          height: 17,
                        ),
                      ],
                    ),
                    actions: [
                      AppButtons.containerTextButton(
                        TextUtils.textHeader(
                          " Confirm",
                          headerTextColor: Colors.white,
                          myfontFamily: "Roboto",
                          fontSize: 20,
                        ),
                        () {
                          if (CacheHelper.getData(key: "role") == "parent")
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ParentSignUpScreen(),
                              ),
                            );
                          else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Doctorsignupscreen(),
                              ),
                            );
                          }
                        },
                        containerColor: const Color(0xFF133E87),
                        containerWidth: 380,
                        containerHeight: 57,
                      ),
                    ],
                  );
                },
              );
            });
          } else if (state is SignUpresetCodeErrorState) {
            // Delay to show dialog after the frame is built
            Future.delayed(Duration.zero, () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 13,
                        ),
                        TextUtils.textHeader("Error!", fontSize: 24),
                        TextUtils.textDescription(
                            " Wrong verification Code Try again ",
                            fontSize: 20),
                        const SizedBox(
                          height: 17,
                        ),
                      ],
                    ),
                    actions: [
                      AppButtons.containerTextButton(
                        TextUtils.textHeader(
                          " OK",
                          headerTextColor: Colors.white,
                          myfontFamily: "Roboto",
                          fontSize: 20,
                        ),
                        () {
                          Navigator.pop(context);
                        },
                        containerColor: const Color(0xFF133E87),
                        containerWidth: 380,
                        containerHeight: 57,
                      ),
                    ],
                  );
                },
              );
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: AppButtons.arrowbutton(() {
                Navigator.pop(context);
              }),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: 337,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'lib/appassets/images/Polygon.png',
                                width: 328.71,
                                height: 290.03,
                              ),
                              Positioned(
                                bottom: 100,
                                left: 111,
                                child: Image.asset(
                                  'lib/appassets/images/email1.png',
                                  width: 115,
                                  height: 115,
                                ),
                              ),
                            ],
                          ),
                          TextUtils.textHeader(" Verify your email",
                              fontSize: 24,
                              myfontFamily: 'Roboto',
                              myTextAlign: TextAlign.start),
                          const SizedBox(
                            height: 11,
                          ),
                          TextUtils.textDescription(
                            "Please enter the verification code we just sent on your email address",
                            myfontFamily: 'Roboto',
                            fontSize: 12,
                            my_FontWeight: FontWeight.w500,
                            myTextAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          OtpTextField(
                            handleControllers: (controllers) {
                              SignUpCubit.get(context).Pintextcontroller =
                                  controllers;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(
                                  1), // Limits input to 1 character per field
                            ],
                            fieldWidth: 60,
                            fieldHeight: 60,
                            numberOfFields: 4,

                            margin: const EdgeInsets.only(
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
                            onSubmit: (String v) {
                              SignUpCubit.get(context).verificationCode = v;
                              // showDialog(
                              //     context: context,
                              //     builder: (context) {
                              //       return AlertDialog(
                              //         title: const Text("Verification Code"),
                              //         content: Text(
                              //             'Code entered is $verificationCode'),
                              //       );
                              //     });
                            }, // end onSubmit
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    AppButtons.simpleTxtButton(
                      TextUtils.textDescription(
                        "Resend code",
                        disTextColor: const Color(0xFF133E87),
                        fontSize: 18,
                      ),
                      () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ConditionalBuilder(
                      condition: state is! SignUpresetCodeLoadingState,
                      builder: (context) => AppButtons.containerTextButton(
                          TextUtils.textHeader(
                            "Send code",
                            headerTextColor: Colors.white,
                            myfontFamily: "Roboto",
                            fontSize: 20,
                          ), () {
                        SignUpCubit.get(context).verifyemail();
                      },
                          containerColor: const Color(0xFF25B9D3),
                          containerWidth: 380,
                          containerHeight: 57),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppButtons.simpleTxtButton(
                      TextUtils.textDescription(
                        "Change Email",
                        disTextColor: const Color(0xFF133E87),
                        fontSize: 18,
                      ),
                      () {},
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
