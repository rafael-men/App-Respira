import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  // fonte global
  static const fontFamily = 'LibreBaskerville';

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.purple700,
      primary: AppColors.purple700,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
    );

    final borda = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: AppColors.purple500.withValues(alpha: 0.3)),
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: ThemeData.light().textTheme.apply(
        fontFamily: fontFamily,
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        prefixIconColor: AppColors.purple500,
        suffixIconColor: AppColors.purple500,
        border: borda,
        enabledBorder: borda,
        focusedBorder: borda.copyWith(
          borderSide: const BorderSide(color: AppColors.purple700, width: 2),
        ),
      ),
    );
  }
}
