import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  static const _primaryLight = Color(0xFF6C5CE7);
  static const _primaryDark = Color(0xFF9B8FFF);
  static const _secondaryLight = Color(0xFF00CEC9);
  static const _secondaryDark = Color(0xFF55EFC4);

  static ThemeData get lightTheme {
    final cs = ColorScheme.fromSeed(seedColor: _primaryLight, brightness: Brightness.light, primary: _primaryLight, secondary: _secondaryLight);
    return ThemeData(
      useMaterial3: true, colorScheme: cs, textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: AppBarTheme(centerTitle: true, elevation: 0, backgroundColor: cs.surface, foregroundColor: cs.onSurface, surfaceTintColor: Colors.transparent),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: _primaryLight, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600))),
      outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(foregroundColor: _primaryLight, minimumSize: const Size(double.infinity, 52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), side: const BorderSide(color: _primaryLight))),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.5), contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: _primaryLight, width: 2))),
      cardTheme: CardThemeData(elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(type: BottomNavigationBarType.fixed, selectedItemColor: _primaryLight, unselectedItemColor: cs.onSurfaceVariant),
    );
  }

  static ThemeData get darkTheme {
    final cs = ColorScheme.fromSeed(seedColor: _primaryDark, brightness: Brightness.dark, primary: _primaryDark, secondary: _secondaryDark);
    return ThemeData(
      useMaterial3: true, colorScheme: cs, scaffoldBackgroundColor: const Color(0xFF0D0D0D),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(centerTitle: true, elevation: 0, backgroundColor: const Color(0xFF0D0D0D), foregroundColor: cs.onSurface, surfaceTintColor: Colors.transparent),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: _primaryDark, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
      outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(foregroundColor: _primaryDark, minimumSize: const Size(double.infinity, 52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), side: const BorderSide(color: _primaryDark))),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: const Color(0xFF1A1A1A), contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: _primaryDark, width: 2))),
      cardTheme: CardThemeData(elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), color: const Color(0xFF1A1A1A)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(type: BottomNavigationBarType.fixed, backgroundColor: const Color(0xFF0D0D0D), selectedItemColor: _primaryDark, unselectedItemColor: cs.onSurfaceVariant),
    );
  }
}
