import 'package:asdsmartcare/networking/api_result.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/SignUp/Widgets/DoctorSignUpForm.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/DoctorCubit/doctor_cubit.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/DoctorCubit/doctor_state.dart';
import 'package:asdsmartcare/presentation/SignUp/screen/EmailVerfcationScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/SelectUserTypeScreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Doctorsignupscreen extends StatelessWidget {
  const Doctorsignupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorSignUpCubit(),
      child: BlocConsumer<DoctorSignUpCubit, DoctorSignUpState>(
        listener: (context, state) {
          if (state is DoctorSignUpSuccessState)
          {
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Text(" Sign Up Success !!"),
              ),
            );
        
             Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loginscreen()),
                              (Route<dynamic> route) => false,
                            );
                         
          }
          if(state is DoctorSignUpErrorState)
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text(state.error),
              ),
            );
          
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset:
                true, // Ensures keyboard doesn't overlap content
            appBar: AppBar(
              leading: AppButtons.arrowbutton(() {
                Navigator.pop(context);
              }),
            ),
            body: SafeArea(
              // Ensures UI is not clipped on devices with notches
              child: SingleChildScrollView(
                // Makes content scrollable
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
                      Doctorsignupform(),
                      const SizedBox(height: 47),
                      // the emile should not be in the data base the verfication code shold first know then if its right we do the sign in
                      // "Next Step" Button
                      ConditionalBuilder(
                        condition: state is! DoctorSignUpLoadingState,
                        builder: (context) => AppButtons.containerTextButton(
                        TextUtils.textHeader(
                          "Next Step ",
                          headerTextColor: Colors.white,
                          myfontFamily: "Roboto",
                          fontSize: 20,
                        ),
                        () {
                          DoctorSignUpCubit.get(context).doctorSignUp();
                        },
                      ),
                     
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      
                      const SizedBox(height: 26),
                      // "Login" Link
                      const MyRichtext(
                        navgaitto: Loginscreen(),
                        Textdis: "You have an account? ",
                        Textheader: " Login",
                      ),
                      const SizedBox(
                          height: 20), // Padding at the bottom for extra space
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
