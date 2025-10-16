import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/auth/signup/views/doctor_signup_form.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/doctor_signup_cubit.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/doctor_signup_state.dart';
import 'package:asdsmartcare/shared/auth/login/views/auth_rich_text.dart';
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
          if (state is DoctorSignUpSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Text(' Sign Up Success !!'),
              ),
            );

            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (Route<dynamic> route) => false,
            );
          }
          if (state is DoctorSignUpErrorState) {
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
            resizeToAvoidBottomInset:
                true, // Ensures keyboard doesn't overlap content
            appBar: const AppHeader(),
            body: SafeArea(
              // Ensures UI is not clipped on devices with notches
              child: SingleChildScrollView(
                // Makes content scrollable
                child: Column(
                  children: [
                    const PageHeader(
                      title: 'Sign up',
                      subtitle: 'Create your doctor account',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 14),
                          const Text(
                            'Create an account to use our service.',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Doctorsignupform(),
                          const SizedBox(height: 47),
                          // the emile should not be in the data base the verfication code shold first know then if its right we do the sign in
                          // "Next Step" Button
                          ConditionalBuilder(
                            condition: state is! DoctorSignUpLoadingState,
                            builder: (context) => AppButton(
                              label: 'Next Step',
                              onPressed: () {
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
                            routeName: '/login',
                            Textdis: 'You have an account? ',
                            Textheader: ' Login',
                          ),
                          const SizedBox(
                              height:
                                  20), // Padding at the bottom for extra space
                        ],
                      ),
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
