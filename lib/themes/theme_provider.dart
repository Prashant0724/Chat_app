// import 'package:chat_app_koko/themes/dark_mode.dart';
// import 'package:chat_app_koko/themes/light_mode.dart';
// import 'package:flutter/material.dart';
//
// class ThemeProvider extends ChangeNotifier{
//   ThemeData _themeData = lightMode;
//
//   ThemeData get themeData => _themeData;
//
//   bool get isDarkMode => _themeData == darkMode;
//
//   set themData(ThemeData themeData){
//     _themeData = themeData;
//     notifyListeners();
//   }
//
//   void toggleTheme(){
//     if(_themeData == lightMode){
//       themeData = darkMode;
//     }else{
//       themeData = lightMode;
//     }
//   }
// }

import 'package:chat_app_koko/themes/dark_mode.dart';
import 'package:chat_app_koko/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) { // Corrected spelling here
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
