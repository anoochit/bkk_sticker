import 'package:bkk_sticker/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BKK Sticker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00744B),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF00744B),
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}
