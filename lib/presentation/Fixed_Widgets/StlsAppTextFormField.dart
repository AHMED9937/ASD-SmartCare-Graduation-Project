import 'dart:io';
import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class StlsAppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final ValueChanged<String?>? onChanged;
  final bool isFilePicker;
  final Future<void> Function()? pickFile;

  const StlsAppTextFormField({
    Key? key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    required this.hintText,
    this.keyboardType,
    this.controller,
    this.validator,
    this.onTap,
    this.isDropdown = false,
    this.dropdownItems,
    this.onChanged,
    this.isFilePicker = false,
    this.pickFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDropdown) {
      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(vertical: 16.5, horizontal: 7),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFFB5B1B1), width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFFB5B1B1), width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
          hintStyle: hintStyle ??
              const TextStyle(color: Color.fromRGBO(62, 135, 107, 0.42)),
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        items: dropdownItems
                ?.map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList() ??
            [],
        onChanged: onChanged,
      );
    }

    final readOnly = isFilePicker;

    return TextFormField(
      readOnly: readOnly,
      onTap: readOnly
          ? () async {
              if (pickFile != null) await pickFile!();
            }
          : onTap,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 16.5, horizontal: 19),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xFFB5B1B1), width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xFFB5B1B1), width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
        hintStyle: hintStyle ??
            const TextStyle(color: Color.fromRGBO(62, 135, 107, 0.42)),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      style: inputTextStyle ??
          const TextStyle(fontSize: 16, color: Colors.black),
    );
  }
}
