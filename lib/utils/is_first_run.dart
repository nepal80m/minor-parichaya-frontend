import 'package:shared_preferences/shared_preferences.dart';

class IsFirstRun {
  IsFirstRun._privateConstructor();

  static final IsFirstRun instance = IsFirstRun._privateConstructor();
  setBooleanValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  Future<bool> getBooleanValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? false;
  }
}
