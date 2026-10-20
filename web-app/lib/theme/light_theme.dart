import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'OpenSans',
  primaryColor: const Color(0xFF016DF6),
  brightness: Brightness.light,
  cardColor: const Color(0xFFFFFFFF),
  hintColor: const Color(0xFF979797),
  scaffoldBackgroundColor: const Color(0xFFF6F9FE),
  secondaryHeaderColor: const Color(0xFF016DF6),
  primaryColorDark: const Color(0xFF043268),

  colorScheme: const ColorScheme.light(
    primary: Color(0xFF043268),
    secondaryContainer: Color(0xFF043268),
    error: Color(0xFFE84D4F),
    secondaryFixed: Color(0xFF00C090),
    tertiaryContainer: Color(0xFF00C090),
    secondary: Color(0xFF016DF6),
    surfaceContainer: Color(0xFF00C090),
    onSecondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFFFFFFFF),
    outline: Color(0xFFFFFFFF),

  ),
);