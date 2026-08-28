import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme _buildTextTheme(Brightness brightness) {
    final baseTheme = brightness == Brightness.dark ? ThemeData.dark().textTheme : ThemeData.light().textTheme;
    final color = brightness == Brightness.dark ? Colors.white : Colors.black;
    
    // Nura for Display, Montserrat for Body
    return GoogleFonts.montserratTextTheme(baseTheme).copyWith(
      displayLarge: TextStyle(fontFamily: 'Nura', color: color, fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontFamily: 'Nura', color: color, fontSize: 28, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontFamily: 'Nura', color: color, fontSize: 24, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontFamily: 'Nura', color: color, fontSize: 20, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontFamily: 'Nura', color: color, fontSize: 18, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontFamily: 'Nura', color: color, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFFC9A24B),
      scaffoldBackgroundColor: const Color(0xFFF9F6F0),
      textTheme: _buildTextTheme(Brightness.light),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFC9A24B),
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFC9A24B),
      scaffoldBackgroundColor: const Color(0xFF1E1C1A),
      textTheme: _buildTextTheme(Brightness.dark),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFC9A24B),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}
