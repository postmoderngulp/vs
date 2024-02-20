import 'package:flutter/material.dart';
import 'package:vs1/presentation/style/colors.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
      textTheme: const TextTheme(
          labelSmall: TextStyle(
              fontSize: 7.45,
              color: colors.text4,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400),
          labelMedium: TextStyle(
              fontSize: 12,
              color: colors.gray1,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400)),
      shadowColor: Colors.grey.shade50,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      iconTheme: const IconThemeData(color: colors.gray2),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: colors.gray1,
          focusColor: colors.gray1,
          hoverColor: colors.gray1,
          outlineBorder: const BorderSide(color: colors.gray1),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: colors.gray1),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      colorScheme: const ColorScheme.light(
        secondary: colors.gray1,
        onSecondary: colors.gray1,
        outline: Colors.transparent,
        primary: Colors.white,
        onPrimary: Colors.white,
        background: Colors.white,
      ));

  static ThemeData darkTheme = ThemeData(
      textTheme: const TextTheme(
          labelSmall: TextStyle(
              fontSize: 7.45,
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400),
          labelMedium: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400)),
      shadowColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.white),
      scaffoldBackgroundColor: colors.primaryDark,
      appBarTheme: const AppBarTheme(backgroundColor: colors.secondaryDark),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: colors.secondaryDark,
          focusColor: colors.secondaryDark,
          hoverColor: colors.secondaryDark,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: colors.secondaryDark),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: colors.primaryDark,
      ),
      colorScheme: const ColorScheme.dark(
          background: colors.secondaryDark,
          primary: colors.primaryDark,
          onPrimary: colors.primaryDark,
          secondary: colors.secondaryDark,
          onSecondary: colors.secondaryDark,
          primaryContainer: colors.secondaryDark));
}
