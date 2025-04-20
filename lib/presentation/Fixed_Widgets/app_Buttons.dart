import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButtons {
  // ContainerTextButton: A customizable button with a text widget inside a styled container
  static Widget containerTextButton(
      Widget txtWidget,
       VoidCallback onePressFunc, {
        double ? containerWidth ,
        double ? containerHeight,
        BorderRadius ?containerBorderRadius ,
        Color ? containerColor,
      }) {
    return TextButton(
      
      onPressed: onePressFunc, // Correctly passing the function
      child: Container(
        width: containerWidth ?? 346.0,
        height: containerHeight ??57.35,
        
        decoration: BoxDecoration(
          color: containerColor ??const Color(0xFF133E87),
          
          borderRadius: containerBorderRadius??const BorderRadius.all(Radius.circular(48)),
        ),
        child: Center( // Use Center widget instead of Column for single child
          child: txtWidget,
        ),
      ),
    );
  }

  // SimpleTxtButton: A plain TextButton with a text widget
  static Widget simpleTxtButton(Widget txtWidget, VoidCallback onePressFunc) {
    return TextButton(
      onPressed: onePressFunc, // Correctly passing the function
      child: txtWidget,
    );
  }
  static Widget arrowbutton(onPressed)
  {
  return    IconButton(
    icon: Icon(Icons.arrow_back_ios, color: Color(0xFF133E87),size: 33,),
    onPressed: onPressed,
  );
  }

}
