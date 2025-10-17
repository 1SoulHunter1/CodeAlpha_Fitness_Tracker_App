import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- NEW COLOR PALETTE ---
  // A fresh, health-themed palette as requested.
  static const Color primaryColor = Color(0xFF4CAF50); // Green for health
  static const Color secondaryColor = Color(0xFF2196F3); // Blue for activity
  static const Color lightBg = Color(0xFFF5F5F5);
  static const Color darkBg = Color(0xFF121212);
  static const Color lightCard = Colors.white;
  static const Color darkCard = Color(0xFF1E1E1E);

  // --- TYPOGRAPHY ---
  // Using Google Fonts 'Poppins' for a clean and modern feel.
  static TextTheme _buildTextTheme(TextTheme base, Color textColor) {
    return base
        .copyWith(
          headlineSmall: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
          titleLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
          titleMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.normal,
            color: textColor,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.normal,
            color: textColor,
          ),
          labelLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        )
        .apply(displayColor: textColor, bodyColor: textColor);
  }

  // --- LIGHT THEME ---
  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        background: lightBg,
        surface: lightCard,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: Colors.black87,
        onSurface: Colors.black87,
      ),
      scaffoldBackgroundColor: lightBg,
      textTheme: _buildTextTheme(base.textTheme, Colors.black87),
      // --- FIX IS HERE ---
      // Changed CardTheme(...) to CardThemeData(...)
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: lightBg,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  // --- DARK THEME ---
  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        background: darkBg,
        surface: darkCard,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: Colors.white70,
        onSurface: Colors.white70,
      ),
      scaffoldBackgroundColor: darkBg,
      textTheme: _buildTextTheme(base.textTheme, Colors.white70),
      // --- FIX IS HERE ---
      // Changed CardTheme(...) to CardThemeData(...)
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkBg,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
