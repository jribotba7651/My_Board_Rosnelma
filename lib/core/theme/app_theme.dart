import 'package:my_board/imports.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.semiBold,
            height: 1.0,
            fontSize: 16),
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 25,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
          size: 30,
        )),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: "Inter Regular"),
      headlineMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: "Inter Regular"),
      headlineSmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontFamily: "Inter Regular"),
      bodyLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: "Inter Regular"),
      bodyMedium: TextStyle(
          color: Colors.black,
          fontFamily: "Inter Regular",
          fontWeight: FontWeight.w500),
      bodySmall: TextStyle(color: Colors.grey, fontFamily: "Inter Regular"),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.appColor,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: "Inter Regular",
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 3,
        //side:
        //BorderSide(color: Colors.black, width: 2.5),
      ),
    ),

    // checkboxTheme: CheckboxThemeData(
    //   overlayColor: MaterialStateProperty.all(AppColors.primaryColor),
    //   checkColor: MaterialStateProperty.all(AppColors.primaryColor),
    //   fillColor: MaterialStateProperty.all(AppColors.primaryColor),
    //   shape: RoundedRectangleBorder(
    //     // Making around shape
    //       borderRadius: BorderRadius.circular(2)),
    // ),

    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: Colors.black,
      hintStyle: TextStyles.smallText
          ?.copyWith(fontWeight: FontWeight.normal, color: Colors.black26),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 30),
      filled: true,
      fillColor: AppColors.textFieldBackGround,
      prefixIconColor: Colors.grey.withOpacity(0.5),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(width: 1.0, color: Colors.grey.withOpacity(0.1))),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1.0,
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(width: 1.0, color: Colors.grey.withOpacity(0.1))),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(width: 1.0, color: Colors.grey.withOpacity(0.1))),
    ),
  );
}
