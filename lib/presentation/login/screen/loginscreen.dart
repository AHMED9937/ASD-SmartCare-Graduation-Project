import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/AsdAppLayouts/screens/DoctorNavgationScreen.dart';
import 'package:asdsmartcare/presentation/AsdAppLayouts/screens/ParentNavgationScreen.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/SignUp/screen/ParentSignUpScreen.dart';
import 'package:asdsmartcare/presentation/SignUp/screen/Selectusertypescreen.dart';
import 'package:asdsmartcare/presentation/login/LoginCubits/Usercubit/login_cubit.dart';
import 'package:asdsmartcare/presentation/login/LoginCubits/Usercubit/login_state.dart';

import 'package:asdsmartcare/presentation/login/widgets/loginform.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// login_screen.dart

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserLoginCubit(),
      child: BlocConsumer<UserLoginCubit, UserLoginState>(
        listener: (context, state) {
          // login_screen.dart → listener:
          if (state is LoginSuccess) {
            // both models expose `.token` and `.data.role`
            final token = state.userModel.token as String;
            CacheHelper.removeData(key:"degree_prediction" );
            CacheHelper.removeData(key: "AsdLevel");
            CacheHelper.SaveData(key: "role", value: state.userModel.data.role);
            CacheHelper.SaveData(key: "id", value: state.userModel.data.id);
            CacheHelper.SaveData(key: "token", value: token).then((_) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => state.userModel.data.role=="parent"? ParentBottomNavgationScreen():Doctornavgationscreen()),
                (route) => false,
              );
            });
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text("Invalid Email or Password!"),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = UserLoginCubit.get(context);
          return Scaffold(
            appBar: AppBarWithText(context, ""),
            body: SingleChildScrollView(
              child: 
                 
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/appassets/images/logo1.png',
                            width: 121,
                            height: 99,
                          ),
                          const SizedBox(height: 20),
                          TextUtils.textHeader(
                            "Log In",
                            fontSize: 20,
                            myfontFamily: 'Roboto',
                          ),

                            
                          const SizedBox(height: 40),
                          Loginform(),
                          // Login button with validation and state handling
                         ConditionalBuilder(
                        condition: state is! LoginLoading,
                        builder: (_) => AppButtons.containerTextButton(
                          containerHeight: 50,
                          TextUtils.textHeader(
                            "Log in",
                            headerTextColor: Colors.white,
                            myfontFamily: "Roboto",
                            fontSize: 16,
                            
                    
                          ),
                          
                          () {
                            if (cubit.formKey.currentState!.validate()) {
                              print(cubit.emailController.text);
                              print(cubit.passwordController.text);
                              cubit.login(
                                email: cubit.emailController.text,
                                password: cubit.passwordController.text,
                              );
                            }
                          },
                        ),
                        fallback: (_) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                     const SizedBox(height: 12),
                           MyRichtext(
                            navgaitto: Selectusertypescreen(),
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
