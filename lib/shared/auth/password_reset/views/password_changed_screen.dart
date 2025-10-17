import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

class Passwordchangedscreen extends StatelessWidget {
  const Passwordchangedscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const Text(
                  'Password Changed!',
                  style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Description Container
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Your password has been changed successfully.',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),

                // Back to Login Button
                SizedBox(
                  width: double.infinity,
                  height: 67,
                  child: AppButton(
                    label: 'Back to Login',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.login,
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
