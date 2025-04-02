import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/AfterLoginRootes/AsdAppLayouts/screens/BottomNavgationScreen.dart';
import 'package:asdsmartcare/presentation/login/LoginCubits/Usercubit/login_cubit.dart';
import 'package:asdsmartcare/presentation/login/LoginCubits/Usercubit/login_state.dart';

import 'package:asdsmartcare/presentation/login/widgets/loginform.dart';
import 'package:asdsmartcare/presentation/login/widgets/my_RichText.dart';
import 'package:asdsmartcare/presentation/signupCubits/screen/SignUpScreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// look at cashHelper
class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserLoginCubit(),
      child: BlocConsumer<UserLoginCubit, UserLoginState>(
        listener: (context, state) {
          isSuccessLogin(state, context);
          if (state is UserLoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
          const    SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text("Invalid Email or Password!"),
              ),
            );
          }
        },
        builder: (context, state) {
          UserLoginCubit loginCubit = UserLoginCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              leading: AppButtons.arrowbutton(() {
                Navigator.pop(context);
              }),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 77),
                        Image.asset(
                          'lib/appassets/images/logo1.png',
                          width: 121,
                          height: 99,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 322,
                          height: 89,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextUtils.textHeader(
                                "Log in",
                                fontSize: 26,
                                myfontFamily: 'Roboto',
                              ),
                              TextUtils.textDescription(
                                "Lorem ipsum dolor sit amet consectetur.",
                                myfontFamily: 'Roboto',
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Loginform(),
                        const SizedBox(height: 27),
                        // Login button with validation and state handling
                        ConditionalBuilder(
                          condition: state is! UserLoginLoadingState,
                          builder: (context) => AppButtons.containerTextButton(
                              TextUtils.textHeader(
                                "Log in",
                                headerTextColor: Colors.white,
                                myfontFamily: "Roboto",
                                fontSize: 20,
                              ), () {
                            if (loginCubit.formKey.currentState!.validate()) {
                              print(loginCubit.emailtextcontroller.text);
                              print(loginCubit.passwordtextcontroller.text);
                              final String? chosenRole =
                                  CacheHelper.getData(key: "role");
                              loginByRole(chosenRole!, loginCubit);
                            }
                          }, containerColor: const Color(0xFF25B9D3)),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const MyRichtext(
                          navgaitto: Signupscreen(),
                        ),
                      ],
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

  void loginByRole(String chosenRole, UserLoginCubit loginCubit) {
      CacheHelper.SaveData(key: "role", value: chosenRole);

    if (chosenRole == "doctor") {
      loginCubit.DoctorLogin(
        email: loginCubit.emailtextcontroller.text,
        Password: loginCubit.passwordtextcontroller.text,
      );
    } else if (chosenRole == "parent") {
      loginCubit.parentLogin(
        email: loginCubit.emailtextcontroller.text,
        Password: loginCubit.passwordtextcontroller.text,
      );
    }
  }

  void isSuccessLogin(UserLoginState state, BuildContext context) {
    if (state is UserLoginSuccessState) {
      CacheHelper.SaveData(
        key: 'role',
        value: state.myUsermodel.data!.role,
      );
      CacheHelper.SaveData(
        key: 'token',
        value: state.myUsermodel.token,
      ).then((value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Bottomnavgationscreen()),
          (Route<dynamic> route) => false,
        );
      });
    } else if (state is ParentLoginSuccessState) {
      CacheHelper.SaveData(
        key: 'token',
        value: state.myParentmodel.token,
      ).then((value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Bottomnavgationscreen()),
          (Route<dynamic> route) => false,
        );
      });
    } else if (state is DoctorLoginSuccessState) {
      CacheHelper.SaveData(
        key: 'token',
        value: state.myDoctormodel.token,
      ).then((value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Bottomnavgationscreen()),
          (Route<dynamic> route) => false,
        );
      });
    }
  }
}
