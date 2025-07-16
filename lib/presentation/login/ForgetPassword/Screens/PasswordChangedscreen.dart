import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/screen/loginscreen.dart';
import 'package:flutter/material.dart';

class Passwordchangedscreen extends StatelessWidget {
  const Passwordchangedscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'lib/appassets/images/Group22.png',
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 40),

                // Title
                TextUtils.textHeader(
                  "Password Changed!",
                  fontSize: 28,
                  myfontFamily: 'Roboto',
                ),
                const SizedBox(height: 16),

                // Description Container
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    
                                     color: Colors.white,

                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextUtils.textDescription(
                    "Your password has been changed successfully.",
                    myfontFamily: 'Roboto',
                    fontSize: 14,
                    myTextAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),

                // Back to Login Button
                SizedBox(
                  width: double.infinity,
                  height: 67,
                  child: AppButtons.containerTextButton(
                    TextUtils.textHeader(
                      "Back to Login",
                      headerTextColor: Colors.white,
                      myfontFamily: 'Roboto',
                      fontSize: 16,
                    ),
                    () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Loginscreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
