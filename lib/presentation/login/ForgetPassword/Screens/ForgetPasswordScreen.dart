import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/ForgetPassword/cubit/forget_password_cubit.dart';
import 'package:asdsmartcare/presentation/login/ForgetPassword/cubit/forget_password_state.dart';
import 'package:asdsmartcare/presentation/login/ForgetPassword/Screens/OTPVerificationScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/loginform.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Forgetpasswordscreen extends StatelessWidget {
  const Forgetpasswordscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppButtons.arrowbutton(() {
          Navigator.pop(context);
        }),
      ),
      body: BlocProvider(
        create: (context) => ForgetPasswordCubit(),
        child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordstate>(
          listener: (context, state) {
            if (state is CheckEmailSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Text("Success"),
              ),
            );
       
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Otpverificationscreen(),
                  ));
            }
          },
          builder: (context, state) {
            return Center(
              child: Form(
                key: ForgetPasswordCubit.get(context).PasswordFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: 346,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 67.5,
                          ),
                          TextUtils.textHeader("Forgot Password?",
                              fontSize: 36,
                              myfontFamily: 'Roboto',
                              myTextAlign: TextAlign.start),
                          const SizedBox(
                            height: 11,
                          ),
                          TextUtils.textDescription(
                            "Don’t worry! It occurs. Please enter the email address linked with your account.",
                            myfontFamily: 'Roboto',
                            fontSize: 12,
                            myTextAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          SizedBox(
                            width: 346,
                            child: Appformtextfield(
                              formValidator: (p0) {
                                if (p0 == null || p0.isEmpty)
                                  return "Enter Your Email Please! ";
                                return null;
                              },
                              TextController: ForgetPasswordCubit.get(context)
                                  .emailController,
                              hintText: "Enter your email",
                              prefixIcon: Icon(
                                size: 24,
                                Icons.email_outlined,
                                color: Color(0xFF133E87),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    ConditionalBuilder(
                      condition: state is! ForgetPasswordLoading,
                      builder: (context) => AppButtons.containerTextButton(
                          TextUtils.textHeader(
                            "Send code",
                            headerTextColor: Colors.white,
                            myfontFamily: "Roboto",
                            fontSize: 20,
                          ), () {
                        ForgetPasswordCubit.get(context).CheckEmail();
                      }, containerHeight: 57),
                      fallback: (_) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    const MyRichtext(
                      Textdis: "Remember password? ",
                      Textheader: "Log  in",
                      navgaitto: Loginscreen(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
