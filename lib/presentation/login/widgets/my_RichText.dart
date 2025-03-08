import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyRichtext extends StatelessWidget {
  const MyRichtext({
    super.key,
    this.Textdis,
    this.Textheader,
    required this.navgaitto,
    });
  final String? Textdis;
  final String? Textheader;
  final Widget navgaitto;

  @override
  Widget build(BuildContext context) {
    return RichText(
  text:TextSpan(
    text: Textdis ?? "Don’t have an account? ",
    style: TextUtils.myDisTextStyle(),
    children: [
      TextSpan(
        text: Textheader ?? "Sign Up",style:TextUtils. myTextstyleHeader(),
        recognizer: TapGestureRecognizer()..onTap=(){Navigator.push(context, MaterialPageRoute(builder: (context) => navgaitto,));},
        
        ),
      
    ]),
  
  
   );
  }
}