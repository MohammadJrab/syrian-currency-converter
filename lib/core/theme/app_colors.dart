import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color darkBackground = Color(0xFF0D0D0D);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkCard = Color(0xFF242424);
  static const Color metalGrey = Color(0xFF3A3A3A);
  static const Color steelGrey = Color(0xFF5A5A5A);
  static const Color lightSteel = Color(0xFF8A8A8A);
  static const Color silverText = Color(0xFFD0D0D0);
  static const Color whiteText = Color(0xFFF5F5F5);
  static const Color accentBlue = Color(0xFF4A90D9);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color warningOrange = Color(0xFFFF8C00);
  static const Color successGreen = Color(0xFF4CAF50);

  static const LinearGradient metalGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2A2A2A),
      Color(0xFF1A1A1A),
      Color(0xFF0D0D0D),
    ],
  );

  static const LinearGradient appBarGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF2D2D2D),
      Color(0xFF1A1A1A),
    ],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2A2A2A),
      Color(0xFF1E1E1E),
    ],
  );
}
