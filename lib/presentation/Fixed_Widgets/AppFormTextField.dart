import 'package:flutter/material.dart';

class Appformtextfield extends StatelessWidget {
  final EdgeInsetsGeometry? contentpadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final TextInputType? myTextInputType;
  final TextEditingController ?TextController;
 final String? Function(String?)? formValidator;

  const Appformtextfield({
    this.myTextInputType,
    super.key,
    this.enabledBorder,
    this.contentpadding,
    this.focusedBorder,
    this.hintStyle,
    this.inputTextStyle,
    this.isObscureText,
    this.suffixIcon,
    this.prefixIcon,
    required this.hintText,
     this.TextController,
     this.formValidator,
    
  });

  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
      validator: formValidator,
      controller:TextController ,
      keyboardType: myTextInputType,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentpadding??const EdgeInsets.symmetric(
          vertical: 16.5,
          horizontal: 19,
        ),
        focusedBorder:focusedBorder?? OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFB5B1B1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder:enabledBorder?? OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFB5B1B1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        hintStyle: hintStyle ??const TextStyle(
          color: Color.fromRGBO(62, 135, 107, 0.42),
        ),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      obscureText: isObscureText ?? false,
      style:inputTextStyle ??const  TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  
  }
}
