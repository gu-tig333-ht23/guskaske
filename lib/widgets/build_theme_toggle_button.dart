import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

Widget buildThemeToggleButton(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);

  return IconButton(
    icon: Icon(
      themeProvider.themeMode == ThemeModeOption.light
          ? Icons.brightness_4 // Icon for dark mode
          : Icons.brightness_7, // Icon for light mode
    ),
    onPressed: () {
      themeProvider.toggleTheme(); // Toggle the theme mode
    },
  );
}
