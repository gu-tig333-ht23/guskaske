import 'package:flutter/material.dart';
import 'providers/app_state.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'screens/myhomepage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  AppState state = AppState();

  state.fetchList(); // updates Tasks list on startup
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => state),
      ChangeNotifierProvider(create: ((context) => ThemeProvider())),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textTheme = GoogleFonts.latoTextTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        textTheme: textTheme.apply(
          bodyColor: Colors.black, // Text color for light mode
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: textTheme.apply(
          bodyColor: Colors.white, // Text color for dark mode
        ),
      ),
      themeMode: themeProvider.themeMode == ThemeModeOption.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: const MyHomePage(
        title: 'TIG169 TODO',
      ),
    );
  }
}
