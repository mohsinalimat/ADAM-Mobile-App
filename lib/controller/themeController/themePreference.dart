import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const THEME_STATUS = "THEMESTATUS";
  static const FONT_SIZE = "FONTSIZE";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(THEME_STATUS) ?? false;
  }

  setFontSize(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(FONT_SIZE, value);
  }

  Future<String> getFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(FONT_SIZE) ?? "Medium";
  }
}
