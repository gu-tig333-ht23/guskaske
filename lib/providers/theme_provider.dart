import 'package:flutter/material.dart';

enum ThemeModeOption {
  light,
  dark,
}

class ThemeProvider extends ChangeNotifier {
  ThemeModeOption _themeMode = ThemeModeOption.dark;

  ThemeModeOption get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = themeMode == ThemeModeOption.dark
        ? ThemeModeOption.light
        : ThemeModeOption.dark;
    notifyListeners();
  }
}
