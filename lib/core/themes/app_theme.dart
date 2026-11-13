import 'package:flutter/material.dart';
import 'package:tasky/core/themes/app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    cardColor: AppColors.white,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundColor),
    secondaryHeaderColor: AppColors.white,
    highlightColor: AppColors.dark,
    primaryTextTheme: TextTheme(
      titleLarge: TextStyle(
        color: Color(0xff1C1B22),
        fontSize: 22,
        fontWeight: .bold,
      ),
      titleMedium: TextStyle(
        color: Color(0xff1C1B22),
        fontSize: 17,
        fontWeight: .bold,
      ),
      titleSmall: TextStyle(
        color: Color(0xff1C1B22),
        fontSize: 12,
        fontWeight: .bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xffffffff),
    ),
  );

  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundColorDark),
    cardColor: AppColors.black,

    secondaryHeaderColor: AppColors.black,
    highlightColor: AppColors.white,
    primaryTextTheme: TextTheme(
      titleLarge: TextStyle(
        color: Color(0xffffffff),
        fontSize: 22,
        fontWeight: .bold,
      ),
      titleMedium: TextStyle(
        color: Color(0xffffffff),
        fontSize: 17,
        fontWeight: .bold,
      ),
      titleSmall: TextStyle(
        color: Color(0xffffffff),
        fontSize: 12,
        fontWeight: .bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.dark,
    ),
  );
}
//