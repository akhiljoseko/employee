import 'package:flutter/material.dart';

class AppTheme {
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: AppColors.labelGrey,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColors.labelGrey,
      ),
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: AppColors.white,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: AppColors.labelGrey,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.inputBorderGrey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.inputBorderGrey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.inputBorderGrey,
        ),
      ),
    ),
  );
}

class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFFf2f2f2);
  static const labelGrey = Color(0xFF949C9E);
  static const inputBorderGrey = Color(0xFFE5E5E5);
  static const blue = Color(0xFF1DA1F2);
  static const calendarDayBlack = Color(0xFF323238);
}
