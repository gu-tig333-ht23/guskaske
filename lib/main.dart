import 'package:flutter/material.dart';
import 'app_state.dart';
import 'package:provider/provider.dart';
import 'screens/myhomepage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  AppState state = AppState();

  state.fetchList(); // updates Tasks list on startup
  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme().apply(
          bodyColor: brightness == Brightness.light
              ? Colors.black // Text color for light mode
              : Colors.white, // Text color for dark mode
        ),
      ),
      home: const MyHomePage(
        title: 'TIG169 TODO',
      ),
    );
  }
}
