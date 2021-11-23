import 'package:adam/controller/themeController/themePreference.dart';
import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreference darkThemePref = ThemePreference();

  // App Theme
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePref.setDarkTheme(value);

    notifyListeners();
  }

  // Font Size
  String _size = "Medium";

  get size => _size;

  set size(String sizeValue) {
    _size = sizeValue;
    notifyListeners();
  }

  // Enable/Disable Notification
  bool _notify = true;
  bool get notify => _notify;

  set notify(bool value) {
    _notify = value;

    notifyListeners();
  }
}
