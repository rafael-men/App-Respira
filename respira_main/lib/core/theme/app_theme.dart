import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static const fonteTitulos = 'Poppins';
  static const fonteTexto = 'Inter';
  static const fontFamily = fonteTexto;

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

    final texto = ThemeData.light().textTheme.apply(
      fontFamily: fonteTexto,
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );
    TextStyle? titulo(TextStyle? estilo) =>
        estilo?.copyWith(fontFamily: fonteTitulos);
    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: texto.copyWith(
        displayLarge: titulo(texto.displayLarge),
        displayMedium: titulo(texto.displayMedium),
        displaySmall: titulo(texto.displaySmall),
        headlineLarge: titulo(texto.headlineLarge),
        headlineMedium: titulo(texto.headlineMedium),
        headlineSmall: titulo(texto.headlineSmall),
        titleLarge: titulo(texto.titleLarge),
        titleMedium: titulo(texto.titleMedium),
        titleSmall: titulo(texto.titleSmall),
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
