import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextFormField extends StatelessWidget {
  static TextStyle textStyle = TextStyle(
    fontSize: 18,
    color: Colors.white.withOpacity(.7),
  );
  TextAlign textAlign;

  Widget? labelText;
  String hintText;
  IconData? suffixIcon;
  IconData? prefixIcon;
  TextInputType textInputType;
  bool obscureText;
  Function()? onTap;
  Function(String)? onChanged;
  Function(String)? onSubmitted;
  String? Function(String?)? validator;
  Function()? onPressedSuffixIcon;
  TextEditingController? controller;
  InputBorder? focusedBorder;
  InputBorder? enabledBorder;
  double radius;
  List<TextInputFormatter>? inputFormatters;

  DefaultTextFormField({
    this.labelText,
    this.hintText = '',
    this.suffixIcon,
    this.prefixIcon,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.controller,
    this.onTap,
    this.onChanged,
    this.enabledBorder,
    this.focusedBorder,
    this.radius = 10,
    this.onSubmitted,
    this.validator,
    this.inputFormatters,
    this.textAlign = TextAlign.center,
    this.onPressedSuffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        inputFormatters: inputFormatters,
        style: textStyle,
        controller: controller,
        onTap: onTap,
        onFieldSubmitted: onSubmitted,
        validator: validator,
        onChanged: onChanged,
        textAlign: textAlign,
        obscureText: obscureText,
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          hintText: hintText,
          label: labelText,
          hintStyle: textStyle,
          suffixIcon: IconButton(
            onPressed: onPressedSuffixIcon,
            icon: Icon(
              suffixIcon,
              color: Colors.white,
              size: 30,
            ),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.white,
            size: 30,
          ),
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          contentPadding: EdgeInsets.all(20),
        ),
      ),
    );
  }
}
