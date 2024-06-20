import 'package:flutter/material.dart';
import 'package:powerupdata/theme/dark_theme.dart';
import 'package:powerupdata/theme/light_theme.dart';

class ThemeProvider extends ChangeNotifier{

  static const String themeKey = 'theme';



    ThemeData _themeData = lightMode;

    ThemeData get themeData => _themeData;

    bool get isDarkMode => _themeData == darkMode;

    set themeData(ThemeData themeData){
      _themeData = themeData;
      notifyListeners();
    }


    void toggleTheme(){
    if (_themeData == lightMode){
      _themeData = darkMode;
      notifyListeners();
    } else {
      _themeData = lightMode;}
      notifyListeners();
    }
    }

