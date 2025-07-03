import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/ForgetPassword/cubit/forget_password_cubit.dart';
import 'package:asdsmartcare/presentation/login/ForgetPassword/cubit/forget_password_state.dart';
import 'package:asdsmartcare/presentation/login/ForgetPassword/Screens/PasswordChangedscreen.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:asdsmartcare/presentation/login/widgets/loginform.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class CreatenewpasswordScreen extends StatelessWidget {
  const CreatenewpasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordstate>(
        listener: (context, state) {
        if (state is ForgetPasswordSuccess){
           ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Text("Success"),
              ),
            );
            Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Passwordchangedscreen(),
                        ),
                        (route) => false,);
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
              child: Column(
                children: [
                  SizedBox(
                    width: 337,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 67.5,
                        ),
                        TextUtils.textHeader("Create new password",
                            fontSize: 33,
                            myfontFamily: 'Roboto',
                            myTextAlign: TextAlign.start),
                        const SizedBox(
                          height: 11,
                        ),
                        TextUtils.textDescription(
                          "Your new password must be unique from those previously used.",
                          myfontFamily: 'Roboto',
                          fontSize: 12,
                          my_FontWeight: FontWeight.w500,
                          myTextAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        Appformtextfield(
                          hintText: "New Password",
                          TextController: ForgetPasswordCubit.get(context).NewPasswordController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Appformtextfield(
                          hintText: "Confirm Password",
                          TextController: ForgetPasswordCubit.get(context).ConfirmPasswordController,

                          isObscureText: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                   ConditionalBuilder(
                      condition: state is! ForgetPasswordLoading,
                      builder: (context) =>  AppButtons.containerTextButton(
                      TextUtils.textHeader(
                        "Reset Password",
                        headerTextColor: Colors.white,
                        myfontFamily: "Roboto",
                        fontSize: 20,
                      ), () 
                  {
                  
                  ForgetPasswordCubit.get(context).ResetPasswordCall();
                  
                  }, containerWidth: 358, containerHeight: 57),
               fallback: (_) => const Center(
                        child: CircularProgressIndicator(),
                      ),
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
