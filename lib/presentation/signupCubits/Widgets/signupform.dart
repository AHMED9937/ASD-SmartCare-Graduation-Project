import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/signupCubits/cubit/sign_up_cubit.dart';
import 'package:asdsmartcare/presentation/signupCubits/cubit/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupForm extends StatelessWidget {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Form(
            key: SignUpCubit.get(context).formKey,
            child: SizedBox(
              width: 346,
              child: Column(
                children: [
                  Appformtextfield(
                    TextController: SignUpCubit.get(context).userNametextcontroller,
                    hintText: "Enter your User Name",
                    prefixIcon: const Icon(
                      size: 24,
                      Icons.edit,
                      color: Color(0xFF133E87),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Appformtextfield(
                    TextController: SignUpCubit.get(context).phonetextcontroller,
                    hintText: "Enter your phone Number",
                    prefixIcon: const Icon(
                      size: 24,
                      Icons.phone,
                      color: Color(0xFF133E87),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Appformtextfield(
                    TextController: SignUpCubit.get(context).emailtextcontroller,
                    hintText: "Enter your email",
                    prefixIcon: const Icon(
                      size: 24,
                      Icons.email_outlined,
                      color: Color(0xFF133E87),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Appformtextfield(
                    TextController: SignUpCubit.get(context).passwordtextcontroller,
                    hintText: "Enter your password",
                    isObscureText: true,
                    prefixIcon: const Icon(
                      size: 24,
                      Icons.lock_outline,
                      color: Color(0xFF133E87),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Appformtextfield(
                    TextController: SignUpCubit.get(context).confirmPasswordtextcontroller,
                    hintText: "Confirm your password",
                    isObscureText: true,
                    prefixIcon: const Icon(
                      size: 24,
                      Icons.lock_outline,
                      color: Color(0xFF133E87),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Print values after user interaction
                      print(SignUpCubit.get(context)
                          .userNametextcontroller
                          .text);
                      print(SignUpCubit.get(context)
                          .phonetextcontroller
                          .text);
                      print(SignUpCubit.get(context)
                          .emailtextcontroller
                          .text);
                      print(SignUpCubit.get(context)
                          .passwordtextcontroller
                          .text);
                      print(SignUpCubit.get(context)
                          .confirmPasswordtextcontroller
                          .text);
                    },
                    child: const Text("Print Values"),
                  ),
                ],
              ),
            ),
          );
}
}