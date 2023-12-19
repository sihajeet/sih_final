import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:sih_final/pages/splash.dart';

void main() {
  Gemini.init(apiKey: 'AIzaSyAQCo_lc1UOdimjMqA9IHxFkqAFs_7qO7s');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
        scaffoldBackgroundColor: const Color(0xFFEAF0FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1.0,
          titleSpacing: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
