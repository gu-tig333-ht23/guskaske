import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

Widget buildThemeToggleButton(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  final themeMode = themeProvider.themeMode;

  return Switch(
      value: themeMode == ThemeModeOption.light,
      onChanged: (value) {
        themeProvider.toggleTheme();
      },
      activeColor: Colors.amber);
}
