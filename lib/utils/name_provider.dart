import 'package:shared_preferences/shared_preferences.dart';

class NameProvider {
  NameProvider._privateConstructor();

  static final NameProvider instance = NameProvider._privateConstructor();
  setStringValue(String key, String value) async {
    SharedPreferences myNamePrefs = await SharedPreferences.getInstance();
    myNamePrefs.setString(key, value);
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences my_name_Prefs = await SharedPreferences.getInstance();
    return my_name_Prefs.getString(key) ?? "Update your name";
  }
}
