import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkMode = false;

  bool get isDarkMode => _darkMode == true;

  void toggleThemeData() {
    _darkMode = !_darkMode;

    notifyListeners();
  }
}
