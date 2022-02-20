import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool currentTheme = false;

  ThemeMode get themeMode {
    if (currentTheme == false) {
      return ThemeMode.light;
    } else if (currentTheme == true) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  changeTheme(bool theme) async {
    const AnimatedSwitcher(duration: Duration(milliseconds: 0));
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('theme', theme);
    currentTheme = theme;
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    currentTheme = _prefs.getBool('theme') ?? false;
    notifyListeners();
  }
}
