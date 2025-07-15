import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/Parentcubit/parent_sign_up_cubit.dart';
import 'package:asdsmartcare/presentation/SignUp/cubit/Parentcubit/parent_sign_up_state.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Parentsignupform extends StatelessWidget {
  Parentsignupform({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 346,
        child: Column(
          children: [
            Appformtextfield(
              hintText: "Enter your userName",
              TextController:
                  ParentSignUpCubit.get(context).userNametextcontroller,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('lib/appassets/images/editname.png'),
                  width: 24,
                  height: 24,
                ),
              ),
              formValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your user name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Appformtextfield(
              hintText: "Enter your email",
              TextController:
                  ParentSignUpCubit.get(context).emailtextcontroller,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('lib/appassets/images/mail.png'),
                  width: 24,
                  height: 24,
                ),
              ),
              formValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Appformtextfield(
              hintText: "Enter your phone Number",
              TextController:
                  ParentSignUpCubit.get(context).phonetextcontroller,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('lib/appassets/images/phone.png'),
                  width: 24,
                  height: 24,
                ),
              ),
              formValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Appformtextfield(
              hintText: "Enter your password",
              TextController:
                  ParentSignUpCubit.get(context).passwordtextcontroller,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('lib/appassets/images/lock.png'),
                  width: 24,
                  height: 24,
                ),
              ),
              isObscureText: true,
              formValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Appformtextfield(
              hintText: "Confirm password",
              TextController:
                  ParentSignUpCubit.get(context).confirmPasswordtextcontroller,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('lib/appassets/images/lock.png'),
                  width: 24,
                  height: 24,
                ),
              ),
              isObscureText: true,
              formValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value !=
                    ParentSignUpCubit.get(context)
                        .passwordtextcontroller
                        .text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Appformtextfield(
              hintText: "Enter your Age",
              TextController: ParentSignUpCubit.get(context).Agetextcontroller,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('lib/appassets/images/editname.png'),
                  width: 24,
                  height: 24,
                ),
              ),
              myTextInputType: TextInputType.number,
              formValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Appformtextfield(
              hintText: "Enter your Address",
              TextController:
                  ParentSignUpCubit.get(context).addresstextcontroller,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('lib/appassets/images/Address.png'),
                  width: 24,
                  height: 24,
                ),
              ),
              formValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            BlocConsumer<ParentSignUpCubit, ParentSignUpState>(
              listener: (context, state) {
                // TODO: handle success/failure states if needed
              },
              builder: (context, state) {
                return ConditionalBuilder(
                  condition: state is! ParentSignUpLoadingState,
                  builder: (context) => AppButtons.containerTextButton(
                    containerHeight: 50,
                    TextUtils.textHeader(
                      "Next Step ",
                      headerTextColor: Colors.white,
                      myfontFamily: "Roboto",
                      fontSize: 16,
                    ),
                    () {
                      if (_formKey.currentState!.validate()) {
                        ParentSignUpCubit.get(context).ParentSignUp();
                      }
                    },
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            const SizedBox(height: 26),
            const MyRichtext(
              navgaitto: Loginscreen(),
              Textdis: "You have an account? ",
              Textheader: " Login",
            ),
          ],
        ),
      ),
    );
  }
}
