import 'package:asdsmartcare/shared/auth/login/views/login_screen.dart';
import 'package:asdsmartcare/shared/auth/login/views/select_role_screen.dart';
import 'package:asdsmartcare/shared/auth/login/widgets/auth_selection_body.dart';
import 'package:flutter/material.dart';

class AuthSelectionScreen extends StatefulWidget {
  const AuthSelectionScreen({super.key});

  @override
  State<AuthSelectionScreen> createState() => _AuthSelectionScreenState();
}

class _AuthSelectionScreenState extends State<AuthSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AuthSelectionBody(
          onLoginPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          onSignupPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Selectusertypescreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
