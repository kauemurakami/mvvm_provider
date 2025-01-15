import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/api_constants.dart';
import 'package:mvvm_statemanagements/constants/my_app_constants.dart';
import 'package:mvvm_statemanagements/constants/my_theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeMode = MyThemeData.lightTheme;

  ThemeData get themeData => _themeMode;

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isDarkMode = prefs.getBool(MyAppConstants.isDarkTheme) ?? false;
    _themeMode = isDarkMode ? MyThemeData.darkTheme : MyThemeData.lightTheme;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = _themeMode == MyThemeData.darkTheme ? MyThemeData.lightTheme : MyThemeData.darkTheme;
    await prefs.setBool(
      MyAppConstants.isDarkTheme,
      _themeMode == MyThemeData.darkTheme,
    );
    notifyListeners();
  }
}
