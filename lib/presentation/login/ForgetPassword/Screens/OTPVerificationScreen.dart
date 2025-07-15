import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/ForgetPassword/cubit/forget_password_cubit.dart';
import 'package:asdsmartcare/presentation/login/ForgetPassword/cubit/forget_password_state.dart';
import 'package:asdsmartcare/presentation/login/ForgetPassword/Screens/CreatenewpasswordScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Otpverificationscreen extends StatefulWidget {
  const Otpverificationscreen({super.key});
  @override
  _OtpverificationscreenState createState() => _OtpverificationscreenState();
}

class _OtpverificationscreenState extends State<Otpverificationscreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordstate>(
        listener: (context, state) {
          if (state is ResetPasswordCodeSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreatenewpasswordScreen(),
              ),
            );
          } else if (state is ForgetPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBarWithText(context,""),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 337,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 67.5),
                        TextUtils.textHeader(
                          "OTP Verification?",
                          fontSize: 30,
                          myfontFamily: 'Roboto',
                          myTextAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 11),
                        TextUtils.textDescription(
                          "Enter the verification code we just sent on your email address",
                          myfontFamily: 'Roboto',
                          fontSize: 12,
                          my_FontWeight: FontWeight.w500,
                          myTextAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 26),
                        OtpTextField(
                          numberOfFields: 4,
                          fieldWidth: 55,
                          fieldHeight: 55,
                          margin: EdgeInsets.only(right: 24),
                          contentPadding: EdgeInsets.all(20),
                          borderRadius: BorderRadius.circular(8),
                          keyboardType: TextInputType.number,
                          borderColor: Color(0xFF133E87),
                          showFieldAsBox: true,
              
                          handleControllers: (controllers) {
                            // leave empty or store controllers if you need them
                          },
              
                          onCodeChanged: (String code) {
                            // optional: live-validate as user types
                          },
              
                          onSubmit: (String verificationCode) {
                            // store it on the cubit
                            ForgetPasswordCubit.get(context).VerficationCode =
                                verificationCode;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 45),
                  ConditionalBuilder(
                      condition: state is! ForgetPasswordLoading,
                      builder: (context) =>  AppButtons.containerTextButton(
                    TextUtils.textHeader(
                      "Send code",
                      headerTextColor: Colors.white,
                      myfontFamily: "Roboto",
                      fontSize: 16,
                    ),
                    () {
                      // actually *call* your check method:
                      ForgetPasswordCubit.get(context).CheckVerficationCode();
                    },
                    containerWidth: 380,
                    containerHeight: 57,
                  ),
                      fallback: (_) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                   
                  const SizedBox(height: 26),
                  const MyRichtext(
                    Textdis: "Don’t received code?  ",
                    Textheader: "Resend code",
                    navgaitto: Loginscreen(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
