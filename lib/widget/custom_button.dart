import 'package:flutter/material.dart';

class ElevatedButtonW extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onTap;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final double? width;
  final double? height;
  final bool? isLoading;

  const ElevatedButtonW({
    Key? key,
    this.buttonText,
    this.onTap,
    this.buttonColor,
    this.buttonTextColor,
    this.width,
    this.height,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: (isLoading == true) ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
          foregroundColor: buttonTextColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: (isLoading == true)
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                buttonText ?? 'Button',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: buttonTextColor ?? Colors.white,
                ),
              ),
      ),
    );
  }

  // Legacy support - method version
  static Widget build2({
    required String buttonText,
    required VoidCallback onTap,
    Color? buttonColor,
    Color? buttonTextColor,
    double? width,
    double? height,
    bool? isLoading,
  }) {
    return ElevatedButtonW(
      buttonText: buttonText,
      onTap: onTap,
      buttonColor: buttonColor,
      buttonTextColor: buttonTextColor,
      width: width,
      height: height,
      isLoading: isLoading,
    );
  }
}