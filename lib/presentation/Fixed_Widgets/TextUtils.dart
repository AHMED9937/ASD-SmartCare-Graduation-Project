import 'package:flutter/material.dart';

class TextUtils {
  // Constants for screen dimensions (if applicable)


  /// Creates a customizable text widget with optional font size and color.
  static Widget textDescription(String disText, {FontWeight?my_FontWeight, String myfontFamily='Inter',double fontSize = 14, Color disTextColor =  Colors.black,TextAlign ?myTextAlign}) {
    return Text(
      disText,
      textAlign: myTextAlign??TextAlign.center,
      overflow: TextOverflow.clip,
      style: TextStyle(

        fontFamily: myfontFamily, // Ensure 'Inter' is added to your pubspec.yaml.
        fontSize: fontSize,
        color: disTextColor,
        fontWeight: my_FontWeight??FontWeight.w400,
      ),
    );
  }

static TextStyle myTextstyleHeader({final my_fontWeight=FontWeight.w600,final String myfontFamily='Inter',final double fontSize = 16,final Color headerTextColor =  const Color(0xFF133E87)}){
  return TextStyle(
        fontFamily: myfontFamily, // Ensure 'Inter' is added to your pubspec.yaml.
        fontSize: fontSize,
        color: headerTextColor,
        fontWeight: my_fontWeight,
      
      );
}


static TextStyle myDisTextStyle({final my_fontWeight=FontWeight.w400,final String myfontFamily='Inter',final double fontSize = 16,final Color disTextColor = Colors.black}){
  return TextStyle(
        fontFamily: myfontFamily, // Ensure 'Inter' is added to your pubspec.yaml.
        fontSize: fontSize,
        color: disTextColor,
        fontWeight: my_fontWeight,
      
      );
}

  static Widget textHeader(String disText, {final my_fontWeight=FontWeight.w600,final String myfontFamily='Inter',final double fontSize = 16,final Color headerTextColor =  const Color(0xFF133E87),TextAlign ?myTextAlign}) {
    return  Text(
      disText,
      textAlign: myTextAlign ?? TextAlign.center,
      overflow: TextOverflow.clip,
      maxLines: 2,
      
      style: TextStyle(
        fontFamily: myfontFamily, // Ensure 'Inter' is added to your pubspec.yaml.
        fontSize: fontSize,
        color: headerTextColor,
        fontWeight: my_fontWeight,
      
      ),
    );
  }

// static Widget my_RichText(BuildContext context){

// return RichText(
//   text:TextSpan(
//     text: "Don’t have an account? ",
//     style: TextUtils.myDisTextStyle(),
//     children: [
//       TextSpan(
//         text: "Sign Up",style: myTextstyleHeader(),
//         recognizer: TapGestureRecognizer()..onTap=(){Navigator.push(context, MaterialPageRoute(builder: (context) => Signupscreen(),));},
        
//         ),
      
//     ]),
  
  
//    );

// }


}
