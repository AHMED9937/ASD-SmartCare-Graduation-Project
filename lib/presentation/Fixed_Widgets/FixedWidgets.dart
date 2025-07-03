import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/appImages.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';

AppBar AppBarWithLogo(BuildContext context) => AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: AppButtons.arrowbutton(() => Navigator.pop(context)),
      ),
      centerTitle: true,
      toolbarHeight: 80,
      title: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: LogoImage(60, 60),
      ),
    );
AppBar defaultAppBar(BuildContext context) => AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 80,
      elevation: 0,
    );
void NavgatTO(BuildContext context, Navigate_to) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Navigate_to,
      ));
}

AppBar AppBarWithText(BuildContext context, String text) {
  return AppBar(
     backgroundColor: Colors.transparent,
              elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.only(top: 30),
      child: AppButtons.arrowbutton(() => Navigator.pop(context)),
    ),
    centerTitle: true,
    toolbarHeight: 80,
    title: Padding(
      padding: const EdgeInsets.only(top: 30),
      child: TextUtils.textHeader(text,
          fontSize: 24, headerTextColor: Color(0xFF082F71)),
    ),
  );
}

Widget asdR() => Row(
      children: [
        Container(
          width: 66,
          height: 66,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF000FAF), Color(0xFF000649)],
            ),
          ),
          child: Center(
            child: Container(
              width: 66 - 2 * 6,
              height: 66 - 2 * 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: TextUtils.textHeader(
                  CacheHelper.getData(key: "degree_prediction") ,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        TextUtils.textHeader(
          'Your Autism Level',
          fontSize: 20,
        ),
      ],
    );
