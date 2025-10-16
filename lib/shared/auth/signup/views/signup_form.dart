import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/parent_signup_cubit.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ParentSignUpCubit.get(context).formKey,
      child: SizedBox(
        width: 346,
        child: Column(
          children: [
            AppTextField(
              controller: ParentSignUpCubit.get(context).userNametextcontroller,
              hint: 'Enter your User Name',
              prefixIcon: Icons.edit,
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: ParentSignUpCubit.get(context).phonetextcontroller,
              hint: 'Enter your phone Number',
              prefixIcon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            AppTextField.email(
              controller: ParentSignUpCubit.get(context).emailtextcontroller,
              hint: 'Enter your email',
            ),
            const SizedBox(height: 20),
            AppTextField.password(
              controller: ParentSignUpCubit.get(context).passwordtextcontroller,
              hint: 'Enter your password',
            ),
            const SizedBox(height: 20),
            AppTextField.password(
              controller: ParentSignUpCubit.get(
                context,
              ).confirmPasswordtextcontroller,
              hint: 'Confirm your password',
              label: 'Confirm Password',
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
