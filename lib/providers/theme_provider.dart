import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touch_counter_app/config/theme_config.dart';

class ThemeProvider with ChangeNotifier {
  int isTheme = 0;

  ThemeData getThemeData(){
    if(isTheme == 0)
      return ThemeConfig.classicThemeData();
    else if( isTheme == 1)
      return ThemeConfig.darkThemeData();
    else 
      return ThemeConfig.lightThemeData();
  } 

  set setThemeData(int val) {
    isTheme = val;
    notifyListeners();
  }
}
