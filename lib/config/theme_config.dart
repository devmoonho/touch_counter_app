import 'package:flutter/material.dart';

class ThemeConfig {
  static Color darkBackground = Colors.grey[900];
  static Color pageBackground = Colors.black;
  static ThemeData darkThemeData() {
    return ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      accentColor: Colors.white,
      textSelectionColor: Colors.blue,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(foregroundColor: Colors.black),
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
      canvasColor: Colors.white,
      textSelectionColor: Colors.blue,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(foregroundColor: Colors.white),
      dividerColor: Colors.white54,
    );
  }

  static ThemeData classicThemeData() {
    return ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.orange[400],
      cardColor: Colors.orange[300],
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      accentColor: Colors.white,
      canvasColor: Colors.white,
      textSelectionColor: Colors.blue[300],
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(foregroundColor: Colors.white),
      dividerColor: Colors.white54,
    );
  }
}
