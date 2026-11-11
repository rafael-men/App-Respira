import 'package:flutter/material.dart';

abstract final class AppColors {
  static const purple900 = Color(0xFF3D2E6B);
  static const purple700 = Color(0xFF5B4A94);
  static const purple500 = Color(0xFF8778C3);
  static const blue400 = Color(0xFF9DC2ED);
  static const blue300 = Color(0xFFC3DCF5);
  static const background = Color(0xFFF6F5FC);
  static const textPrimary = Color(0xFF2E2A45);
  static const textSecondary = Color(0xFF6E6788);
  static const emergency = Color(0xFFE1483D);
  static const emergencyDark = Color(0xFFC23B31);
  static const error = Color(0xFFB3261E);

  static const brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [purple700, purple500],
  );
}
