import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:asdsmartcare/core/ui/buttons/app_button.dart';
import 'package:asdsmartcare/core/ui/text_fields/app_text_field.dart';
import 'package:asdsmartcare/shared/auth/login/views/auth_rich_text.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/parent_signup_cubit.dart';
import 'package:asdsmartcare/shared/auth/signup/controllers/parent_signup_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentSignupBody extends StatefulWidget {
  const ParentSignupBody({super.key});

  @override
  State<ParentSignupBody> createState() => _ParentSignupBodyState();
}

class _ParentSignupBodyState extends State<ParentSignupBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = ParentSignUpCubit.get(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // Header Text
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Join as a Parent to track progress',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Form Fields
            // Form Fields
            Column(
              children: [
                AppTextField(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  controller: cubit.userNametextcontroller,
                  prefixIcon: Icons.person_outline_rounded,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full name is required';
                    }
                    if (value.length < 3) {
                      return 'Name must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField.email(
                  label: 'Email Address',
                  hint: 'Enter your email',
                  controller: cubit.emailtextcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Phone Number',
                  hint: 'Enter your phone number',
                  controller: cubit.phonetextcontroller,
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Phone number must contain only digits';
                    }
                    if (value.length < 10) {
                      return 'Phone number must be at least 10 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Age',
                        hint: 'Years',
                        controller: cubit.Agetextcontroller,
                        prefixIcon: Icons.cake_outlined,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          final age = int.tryParse(value);
                          if (age == null) {
                            return 'Invalid';
                          }
                          if (age < 18) {
                            return '18+ only';
                          }
                          if (age > 100) {
                            return 'Invalid';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: AppTextField(
                        label: 'Address',
                        hint: 'City / Region',
                        controller: cubit.addresstextcontroller,
                        prefixIcon: Icons.location_on_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Address is required';
                          }
                          if (value.length < 2) {
                            return 'Please enter a specific address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AppTextField.password(
                  label: 'Password',
                  hint: 'Enter strong password',
                  controller: cubit.passwordtextcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField.password(
                  label: 'Confirm Password',
                  hint: 'Re-enter password',
                  controller: cubit.confirmPasswordtextcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != cubit.passwordtextcontroller.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Action Button
            BlocConsumer<ParentSignUpCubit, ParentSignUpState>(
              listener: (context, state) {},
              builder: (context, state) {
                return ConditionalBuilder(
                  condition: state is! ParentSignUpLoadingState,
                  builder: (context) => AppButton(
                    label: 'Create Account',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.ParentSignUp();
                      }
                    },
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Center(
              child: MyRichtext(
                routeName:
                    '/login', // Use explicit route if AppRoutes isn't handy here
                Textdis: 'Already have an account? ',
                Textheader: 'Log In',
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
