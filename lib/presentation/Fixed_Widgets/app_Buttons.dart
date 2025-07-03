import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButtons {
  // ContainerTextButton: A customizable button with a text widget inside a styled container
  static Widget containerTextButton(
  Widget txtWidget,
  VoidCallback onePressFunc, {
  double containerWidth=358,
  double containerHeight=57,
  BorderRadius? containerBorderRadius,
  Color? containerColor,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextButton(
      onPressed: onePressFunc,
      style: TextButton.styleFrom(
        backgroundColor: containerColor ?? const Color(0xFF133E87),
        shape: RoundedRectangleBorder(
          borderRadius: containerBorderRadius ??
              const BorderRadius.all(Radius.circular(11)),
        ),
        // only force a fixedSize when both width & height are passed
        fixedSize: (containerWidth != null && containerHeight != null)
            ? Size(containerWidth, containerHeight)
            : null,
        // otherwise give it comfortable padding around its child
        padding: (containerWidth == null && containerHeight == null)
            ? const EdgeInsets.symmetric(horizontal: 33,vertical: 6)
            : EdgeInsets.zero,
      ),
      child: txtWidget,
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
