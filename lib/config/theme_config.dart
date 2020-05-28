import 'package:flutter/material.dart';

class ThemeConfig {
  static Color darkBackground = Colors.grey[900];
  static Color pageBackground = Colors.black;

  static ThemeData classicThemeData() {
    return ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.orange[400],
      secondaryHeaderColor: Colors.orange[300],
      primaryColorDark: Colors.orange[300],
      primaryColorLight: Colors.white,
      indicatorColor: Colors.grey,
      highlightColor: Colors.black54,
      accentColor: Colors.orange[200],
      canvasColor: Colors.white,
      textSelectionHandleColor: Colors.black,
      textSelectionColor: Colors.grey[500],
      brightness: Brightness.light,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(foregroundColor: Colors.white),
      dividerColor: Colors.white54,
    );
  }

  static ThemeData darkThemeData() {
    return ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      secondaryHeaderColor: Colors.grey[900],
      primaryColorDark: Colors.black45,
      primaryColorLight: Colors.white,
      indicatorColor: Colors.grey,
      highlightColor: Colors.black54,
      accentColor: Colors.white,
      canvasColor: Colors.grey[800],
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      textSelectionColor: Colors.grey[500],
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(foregroundColor: Colors.black),
      dividerColor: Colors.black54,
    );
  }

  static ThemeData lightThemeData() {
    return ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.grey[500],
      secondaryHeaderColor: Colors.grey[300],
      primaryColorDark: Colors.black45,
      primaryColorLight: Colors.grey,
      indicatorColor: Colors.grey,
      highlightColor: Colors.black54,
      accentColor: Colors.white,
      canvasColor: Colors.grey[100],
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      textSelectionColor: Colors.grey[500],
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(foregroundColor: Colors.white),
      dividerColor: Colors.white54,
    );
  }
}
