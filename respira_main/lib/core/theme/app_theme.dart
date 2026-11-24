import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static const fonteTitulos = 'PlayfairDisplay';
  static const fonteTexto = 'Inter';
  static const fontFamily = fonteTexto;

  static final ThemeData light = _criar(Brightness.light);
  static final ThemeData dark = _criar(Brightness.dark);

  static ThemeData _criar(Brightness brilho) {
    final escuro = brilho == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.purple700,
      brightness: brilho,
      primary: escuro ? const Color(0xFFCBB9FD) : AppColors.purple700,
      onPrimary: escuro ? AppColors.purple900 : Colors.white,
      surface: escuro ? const Color(0xFF241F38) : Colors.white,
      onSurface: escuro ? const Color(0xFFF2EEF9) : AppColors.textPrimary,
      onSurfaceVariant: escuro
          ? const Color(0xFFCCC3DE)
          : AppColors.textSecondary,
      error: escuro ? const Color(0xFFFFB4AB) : AppColors.error,
    );

    final borda = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: AppColors.purple500.withValues(alpha: 0.3)),
    );

    final texto = ThemeData(brightness: brilho).textTheme.apply(
      fontFamily: fonteTexto,
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );
    TextStyle? titulo(TextStyle? estilo) =>
        estilo?.copyWith(fontFamily: fonteTitulos);
    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: scheme,
      scaffoldBackgroundColor: escuro
          ? const Color(0xFF191627)
          : AppColors.background,
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
        fillColor: scheme.surface,
        labelStyle: TextStyle(color: scheme.onSurfaceVariant),
        prefixIconColor: escuro ? scheme.primary : AppColors.purple500,
        suffixIconColor: escuro ? scheme.primary : AppColors.purple500,
        border: borda,
        enabledBorder: borda,
        focusedBorder: borda.copyWith(
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
    );
  }
}
