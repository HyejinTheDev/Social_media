import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized theme for Vibenex App based on Stitch Design System
class AppTheme {
  AppTheme._();

  // Common Border Radius
  static const _inputBorderRadius = BorderRadius.all(Radius.circular(12));
  static const _cardBorderRadius = BorderRadius.all(Radius.circular(16));

  static const _defaultInputBorder = OutlineInputBorder(
    borderRadius: _inputBorderRadius,
    borderSide: BorderSide.none,
  );

  static const _focusedInputBorder = OutlineInputBorder(
    borderRadius: _inputBorderRadius,
    borderSide: BorderSide(color: AppColors.brandViolet, width: 2),
  );

  static const _errorInputBorder = OutlineInputBorder(
    borderRadius: _inputBorderRadius,
    borderSide: BorderSide(color: AppColors.error, width: 2),
  );

  static ThemeData get darkTheme {
    const cs = ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      error: AppColors.error,
      onError: AppColors.onError,
    );

    final baseTextTheme = GoogleFonts.interTextTheme(ThemeData.dark().textTheme);
    final textTheme = baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.02),
      displayMedium: baseTextTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.02),
      displaySmall: baseTextTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.02),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.02),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: -0.01),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontSize: 15, fontWeight: FontWeight.w400, height: 1.5),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, height: 1.4),
      labelSmall: baseTextTheme.labelSmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.05),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,
      
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent, // Phù hợp với UI blur
        foregroundColor: cs.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.headlineMedium?.copyWith(color: AppColors.textSilver),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandViolet,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Rounded 12px theo spec
          textStyle: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.brandViolet,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: const BorderSide(color: AppColors.brandViolet),
        ),
      ),
      
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainer, // Semi-transparent fill
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: _defaultInputBorder,
        focusedBorder: _focusedInputBorder,
        errorBorder: _errorInputBorder,
        hintStyle: TextStyle(color: AppColors.textFog),
      ),
      
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: _cardBorderRadius,
          side: BorderSide(color: AppColors.borderTwilight, width: 1), // 1px Twilight Gray border
        ),
        color: AppColors.surfaceMidnight, // Card background
        margin: EdgeInsets.zero,
      ),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent, // Sẽ được wrap bằng Glassmorphism
        selectedItemColor: AppColors.brandViolet,
        unselectedItemColor: AppColors.textFog,
        elevation: 0,
      ),
    );
  }

  // Fallback light theme for compatibility if needed (but primarily dark mode)
  static ThemeData get lightTheme {
    return darkTheme; // Force dark theme as the brand is "dark-mode-first"
  }
}
