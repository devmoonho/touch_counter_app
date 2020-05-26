import 'package:flutter/material.dart';

class ThemeConfig {
  static Color darkBackground = Colors.grey[900];
  static Color pageBackground = Colors.black;
  static ThemeData darkThemeData() {
    return ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: Color(0xFF000000),
      accentColor: Colors.white,
      floatingActionButtonTheme : FloatingActionButtonThemeData(foregroundColor: Colors.black),
      dividerColor: Colors.black54,
    );
  }

  static ThemeData lightThemeData() {
    return ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      backgroundColor: Color(0xFFE5E5E5),
      accentColor: Colors.black,
      floatingActionButtonTheme : FloatingActionButtonThemeData(foregroundColor: Colors.white),
      dividerColor: Colors.white54,
    );
  }
}
