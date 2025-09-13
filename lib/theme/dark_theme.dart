import 'package:stackfood_multivendor/util/app_constants.dart';
import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: AppConstants.fontFamily,
  primaryColor: const Color(0xfff25c05),

  // still valid
  secondaryHeaderColor: const Color(0xffff0000),

  disabledColor: const Color(0xff666565),
  brightness: Brightness.dark,
  hintColor: const Color(0xFF5E6472),
  cardColor: const Color(0xFF363434),
  shadowColor: Colors.white.withValues(alpha: 0.03),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFFFF7918),
    ),
  ),

  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF006699),
    tertiary: Color(0xFF006699),
    tertiaryContainer: Color(0xff171DB6),
    secondary: Color(0x9BFF7918),
    onSecondary: Color(0xFFFFFFFF), // ✅ replaces old secondaryHeadColor
  ).copyWith(
    surface: const Color(0xFF272727),
    error: const Color(0xFFdd3135),
  ),

  popupMenuTheme: const PopupMenuThemeData(
    color: Color(0xFF29292D),
    surfaceTintColor: Color(0xFF29292D),
  ),

  dialogTheme: const DialogThemeData(surfaceTintColor: Colors.white),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(500),
    ),
  ),

  bottomAppBarTheme: const BottomAppBarThemeData(
    surfaceTintColor: Colors.black,
    height: 60,
    padding: EdgeInsets.symmetric(vertical: 5),
  ),

  dividerTheme: DividerThemeData(
    color: const Color(0xffa2a7ad).withValues(alpha: 0.25),
    thickness: 0.5,
  ),

  tabBarTheme: const TabBarThemeData(dividerColor: Colors.transparent),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
    titleLarge: TextStyle(color: Colors.white),
  ),
);
