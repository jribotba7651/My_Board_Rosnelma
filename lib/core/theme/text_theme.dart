import 'package:flutter/material.dart';
import 'package:my_board/core/values/colors.dart';
import 'package:my_board/core/values/fonts.dart';

class TextStyles {
  static TextStyle? get h1 => const TextStyle(
      fontSize: 29, fontFamily: AppFonts.semiBold, color: Colors.black);
  static TextStyle? get h2 => const TextStyle(
      fontSize: 22, fontFamily: AppFonts.semiBold, color: Colors.black);
  static TextStyle? get text2 => const TextStyle(
      fontSize: 20, fontFamily: AppFonts.semiBold, color: Colors.black);
  static TextStyle? get text2White => const TextStyle(
      fontSize: 20, fontFamily: AppFonts.semiBold, color: Colors.white);
  static TextStyle? get text3 =>
      const TextStyle(fontSize: 17, color: Colors.black);
  static TextStyle? get text3White =>
      const TextStyle(fontSize: 17, color: Colors.white);
  static TextStyle? get text4White =>
      const TextStyle(fontSize: 14, color: Colors.white);
  static TextStyle? get smallText => const TextStyle(
        fontSize: 15,
        color: Colors.black,
      );
  static TextStyle? get smallTextWhite =>
      const TextStyle(fontSize: 15, color: Colors.white);
  static TextStyle? get largeTextWhite =>
      const TextStyle(fontSize: 32, color: Colors.white);
  static TextStyle? get largeTextPurple =>
      TextStyle(fontSize: 32, color: AppColors.appColor);
  static TextStyle? get smallText2 =>
      const TextStyle(fontSize: 13, color: Colors.black38);
  static TextStyle? get smallText3 =>
      const TextStyle(fontSize: 11, color: Colors.black);
  static TextStyle? get extraSmallText =>
      const TextStyle(fontSize: 08, color: Colors.black);
}
