import 'package:adam/controller/darkModeController/themePreference.dart';
import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreference darkThemePref = ThemePreference();

  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePref.setDarkTheme(value);

    notifyListeners();
  }
}
