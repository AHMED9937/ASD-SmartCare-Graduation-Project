import 'package:asdsmartcare/presentation/Fixed_Widgets/appImages.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';

AppBar AppBarWithLogo(BuildContext context)=> AppBar(
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
AppBar defaultAppBar(BuildContext context)=>  AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 80,
              elevation: 0,
            );
       void NavgatTO(BuildContext context, Widget Navigate_to) {
    Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => Navigate_to,
             ));
  }