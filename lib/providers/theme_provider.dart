import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkModeOn = false;

  ThemeMode get themeMode {
    if (isDarkModeOn == false) {
      return ThemeMode.light;
    } else if (isDarkModeOn == true) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  changeTheme(bool theme) async {
    const AnimatedSwitcher(duration: Duration(milliseconds: 0));
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('theme', theme);
    isDarkModeOn = theme;
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    isDarkModeOn = _prefs.getBool('theme') ?? false;
    notifyListeners();
  }
}
