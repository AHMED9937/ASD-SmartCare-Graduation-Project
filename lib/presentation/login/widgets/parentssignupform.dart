import 'package:flutter/material.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/AppFormTextField.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';

class parentssignupform extends StatefulWidget {
  const parentssignupform({super.key});

  @override
  State<parentssignupform> createState() => _parentssignupformState();
}

class _parentssignupformState extends State<parentssignupform> {
  final formkey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: const Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Appformtextfield(
              hintText: "Enter your Child name",
              prefixIcon: Icon(
                size: 24,
                Icons.edit,
                color: Color(0xFF133E87),
              ),
            ),
            SizedBox(height: 20),
            Appformtextfield(
              hintText: "Enter your Date of Birth",
              prefixIcon: Icon(
                size: 24,
                Icons.date_range,
                color: Color(0xFF133E87),
              ),
              myTextInputType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            Appformtextfield(
              hintText: "Enter your email",
              prefixIcon: Icon(
                size: 24,
                Icons.email_outlined,
                color: Color(0xFF133E87),
              ),
            ),
            SizedBox(height: 20),
            Appformtextfield(
              hintText: "Enter your password",
              isObscureText: true,
              prefixIcon: Icon(
                size: 24,
                Icons.lock_outline,
                color: Color(0xFF133E87),
              ),
            ),
            SizedBox(height: 20),
            Appformtextfield(
              hintText: "Confirm your password",
              isObscureText: true,
              prefixIcon: Icon(
                size: 24,
                Icons.lock_outline,
                color: Color(0xFF133E87),
              ),
            ),
            SizedBox(height: 16),
            // Add Submit Button
          
          ],
        ),
      ),
    );
  }
}
