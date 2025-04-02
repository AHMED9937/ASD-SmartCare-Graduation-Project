import 'dart:io';

import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class Appformtextfield extends StatefulWidget {
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
  final TextEditingController? TextController;
  final String? Function(String?)? formValidator;
  final Function()? MyonTapFunc;
  final bool? isDropdown;
  final List<String>? dropdownItems;
  final Function(String?)? onChanged;
  // Updated to correctly indicate an async function
   Future<void> Function()? pickFile;
  final bool isFilePicker;
  MultipartFile? storedMedicalLicenseFile;
  
  Appformtextfield({
    Key? key,
    this.myTextInputType,
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
    this.MyonTapFunc,
    this.isDropdown = false, // To check if it's a dropdown
    this.dropdownItems,
    this.onChanged,
    this.isFilePicker = false, // Default is false
    this.pickFile,
  }) : super(key: key);

  @override
  _AppformtextfieldState createState() => _AppformtextfieldState();
}

class _AppformtextfieldState extends State<Appformtextfield> {
  List<PlatformFile>? _pickedFileName;

  @override
  Widget build(BuildContext context) {
    // If dropdown mode is enabled, show a DropdownButtonFormField.
    if (widget.isDropdown == true) {
      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: widget.contentpadding ??
              const EdgeInsets.symmetric(vertical: 16.5, horizontal: 7),
          focusedBorder: widget.focusedBorder ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFB5B1B1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
          enabledBorder: widget.enabledBorder ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFB5B1B1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
          hintStyle: widget.hintStyle ??
              const TextStyle(
                color: Color.fromRGBO(62, 135, 107, 0.42),
              ),
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
        ),
        items: widget.dropdownItems
            ?.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: widget.onChanged,
      );
    } else {
      // For file picker mode, override onTap and make the field read-only.
      final bool useFilePicker = widget.isFilePicker;

      return TextFormField(
        readOnly: useFilePicker, // Make readOnly if file picker is enabled
        onTap: useFilePicker
            ? () async {
                if (widget.pickFile != null) {
                  await widget.pickFile!();
                }
              }
            : widget.MyonTapFunc,
        validator: widget.formValidator,
        controller: widget.TextController,
        keyboardType: widget.myTextInputType,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: widget.contentpadding ??
              const EdgeInsets.symmetric(vertical: 16.5, horizontal: 19),
          focusedBorder: widget.focusedBorder ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFB5B1B1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
          enabledBorder: widget.enabledBorder ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFB5B1B1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
          hintStyle: widget.hintStyle ??
              const TextStyle(
                color: Color.fromRGBO(62, 135, 107, 0.42),
              ),
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
        ),
        obscureText: widget.isObscureText ?? false,
        style: widget.inputTextStyle ??
            const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
      );
    }
  }
}
