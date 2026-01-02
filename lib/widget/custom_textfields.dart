import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? image;
  final bool? isShowLeading;
  final TextInputType? textInputType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Function(String)? onchanged; // Alternative naming used in project
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;

  const AppTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.image,
    this.isShowLeading,
    this.textInputType,
    this.obscureText,
    this.suffixIcon,
    this.onChanged,
    this.onchanged,
    this.validator,
    this.maxLines,
    this.maxLength,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText ?? false,
      onChanged: onChanged ?? onchanged,
      maxLength: maxLength,
      validator: validator,
      maxLines: maxLines ?? 1,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: (isShowLeading == false || image == null)
            ? null
            : Icon(Icons.email), // Using default icon since image path may not work
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}