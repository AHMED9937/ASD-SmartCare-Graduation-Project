import 'package:asdsmartcare/core/utils/text_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyRichtext extends StatelessWidget {
  const MyRichtext({
    super.key,
    this.Textdis,
    this.Textheader,
    this.navgaitto,
    this.routeName,
  }) : assert(
         navgaitto != null || routeName != null,
         'Either navgaitto or routeName must be provided',
       );
  final String? Textdis;
  final String? Textheader;
  final Widget? navgaitto;
  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: Textdis ?? 'Don’t have an account? ',
        style: TextUtils.myDisTextStyle(),
        children: [
          TextSpan(
            text: Textheader ?? 'Sign Up',
            style: TextUtils.myTextstyleHeader(),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (routeName != null) {
                  Navigator.pushNamed(context, routeName!);
                } else if (navgaitto != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => navgaitto!),
                  );
                }
              },
          ),
        ],
      ),
    );
  }
}
