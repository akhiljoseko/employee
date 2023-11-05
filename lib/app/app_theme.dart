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
  );
}

class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFFf2f2f2);
  static const labelGrey = Color(0xFF949C9E);
  static const blue = Color(0xFF1DA1F2);
}
