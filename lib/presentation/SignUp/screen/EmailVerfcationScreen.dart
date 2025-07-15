import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/SignUp/screen/AddChildScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/SelectusertypeScreen.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/Parentcubit/parent_sign_up_cubit.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/Parentcubit/parent_sign_up_state.dart';
import 'package:asdsmartcare/presentation/SignUp/screen/DoctorSignUpScreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Emailverfcationscreen extends StatelessWidget {
  final String parentID;
  final String ParentUserName;
  Emailverfcationscreen(
      {super.key, required this.parentID, required this.ParentUserName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentSignUpCubit(),
      child: BlocConsumer<ParentSignUpCubit, ParentSignUpState>(
        listener: (context, state) {
          if (state is DeleteParentSuccessState) {
            Navigator.pop(context);
          }

          if (state is ParentSignUpresetCodeSuccessState) {
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
                                  builder: (context) => AddChildScreen(
                                        ParentId: parentID,
                                      )),
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
          } else if (state is ParentSignUpresetCodeErrorState) {
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
              forceMaterialTransparency: true,
              toolbarHeight: 80,
              leading: AppButtons.arrowbutton(() {
                print(parentID + ParentUserName);
                ParentSignUpCubit.get(context).DeleteParent(
                    ParentId: parentID, ParentUserName: ParentUserName);
              }),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                                fontSize: 16,
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
    ParentSignUpCubit.get(context).Pintextcontroller = controllers;
  },
  inputFormatters:  [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(1),
  ],
  fieldWidth: 60,
  fieldHeight: 60,
  numberOfFields: 4,
  margin: const EdgeInsets.only(right: 12),      // a bit less spacing
  contentPadding: const EdgeInsets.symmetric(    // trimmed padding
    vertical: 0,
    horizontal: 0,
  ),
  borderRadius: BorderRadius.circular(8),
  keyboardType: TextInputType.number,
  borderColor: const Color(0xFF133E87),
  showFieldAsBox: true,

  // **make digits visible**
  textStyle: const TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),

  // **allow long-press paste**
 

  onCodeChanged: (code) {
    // you can do live validation here
  },
  onSubmit: (value) {
    ParentSignUpCubit.get(context).verificationCode = value;
  },
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
                          fontSize: 16,
                        ),
                        () {},
                      ),
                      ConditionalBuilder(
                        condition: state is! ParentSignUpresetCodeLoadingState,
                        builder: (context) => AppButtons.containerTextButton(
                            TextUtils.textHeader(
                              "Send code",
                              headerTextColor: Colors.white,
                              myfontFamily: "Roboto",
                              fontSize: 16,
                            ), () {
                          ParentSignUpCubit.get(context).verifyemail();
                        }, containerWidth: 380, containerHeight: 57),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      AppButtons.simpleTxtButton(
                        TextUtils.textDescription(
                          "Change Email",
                          disTextColor: const Color(0xFF133E87),
                          fontSize: 16,
                        ),
                        () {
                          ParentSignUpCubit.get(context).DeleteParent(
                              ParentId: parentID,
                              ParentUserName: ParentUserName);
                        },
                      ),
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
