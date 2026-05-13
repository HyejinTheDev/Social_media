import 'package:flutter/material.dart';

/// Thư viện màu sắc dựa trên Stitch Design System cho Vibenex
class AppColors {
  AppColors._();

  // Core Backgrounds & Surfaces
  static const Color background = Color(0xFF15121B);
  static const Color backgroundDeep = Color(0xFF0F0F1A);
  static const Color surfaceMidnight = Color(0xFF1A1A2E);
  static const Color surfaceContainer = Color(0xFF211E27);
  static const Color surfaceContainerHigh = Color(0xFF2C2832);
  static const Color surfaceContainerHighest = Color(0xFF37333D);
  
  // Brand Accents
  static const Color brandViolet = Color(0xFF8B5CF6);
  static const Color electricIndigo = Color(0xFF6366F1);
  static const Color hotPink = Color(0xFFEC4899);

  // Material Design Mappings (Dark Mode specific)
  static const Color primary = Color(0xFFD0BCFF);
  static const Color primaryContainer = Color(0xFFA078FF);
  static const Color onPrimary = Color(0xFF3C0091);
  static const Color onPrimaryContainer = Color(0xFF340080);
  
  static const Color secondary = Color(0xFFC0C1FF);
  static const Color onSecondary = Color(0xFF1000A9);
  
  static const Color tertiary = Color(0xFFFFB0CD);
  static const Color onTertiary = Color(0xFF640039);

  static const Color surface = Color(0xFF15121B);
  static const Color onSurface = Color(0xFFE7E0ED); // Tương đương text-silver
  static const Color onSurfaceVariant = Color(0xFFCBC3D7); // Tương đương text-fog
  
  // Text & Borders
  static const Color textSilver = Color(0xFFE2E8F0);
  static const Color textFog = Color(0xFF94A3B8);
  
  static const Color borderTwilight = Color(0xFF2D2D44);
  static const Color outline = Color(0xFF958EA0);
  static const Color outlineVariant = Color(0xFF494454);

  // Status Colors
  static const Color statusEmerald = Color(0xFF10B981);
  static const Color statusAmber = Color(0xFFF59E0B);
  static const Color error = Color(0xFFFFB4AB);
  static const Color onError = Color(0xFF690005);

  // Hero Card & Badges
  static const Color heroGradientStart = Color(0xFF231E38);
  static const Color heroGradientEnd = Color(0xFF141D29);
  
  static const Color badgeStaffPickBg = Color(0xFF5A4441);
  static const Color badgeStaffPickBorder = Color(0xFF7A5C58);
  static const Color badgeStaffPickText = Color(0xFFFBBF24);
  
  static const Color badgeNewBg = Color(0xFF0D9488);
  static const Color badgeNewBorder = Color(0xFF14B8A6);
  static const Color badgeNewText = Color(0xFF5EEAD4);
}
