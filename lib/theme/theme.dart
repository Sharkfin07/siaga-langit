import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(255, 1, 17, 32),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(
      color: Colors.white,
      fontSize: 36,
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
  ),
  fontFamily: GoogleFonts.josefinSans().fontFamily,
);
