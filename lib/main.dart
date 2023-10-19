import 'package:flutter/material.dart';
import 'splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String titleApp = 'DUE CARRARE - Calendario Rifiuti 2023';

    return MaterialApp(
      title: titleApp,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        // colorSchemeSeed: Color.fromARGB(255, 2, 20, 3),
        // useMaterial3: true,
      ),
      // home: const MyHomePage(title: titleApp),
      home: const SplashScreen(titleApp: titleApp),
    );
  }
}


