import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app-colors.dart';

/// Tema Material 3 configurado con los colores y tipografía del Style Tile.
class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    final baseTextTheme = GoogleFonts.robotoTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.neutralBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.flowConfig,
        primary: AppColors.flowConfig,
        secondary: AppColors.flowClosure,
        tertiary: AppColors.flowFocus,
        surface: AppColors.neutralBackground,
      ),
      textTheme: baseTextTheme.copyWith(
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(
          fontSize: 24,
          height: 32 / 24,
          fontWeight: FontWeight.w500,
          color: AppColors.neutralTextPrimary,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          fontSize: 16,
          height: 24 / 16,
          fontWeight: FontWeight.w400,
          color: AppColors.neutralTextPrimary,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w500,
          color: AppColors.neutralTextPrimary,
        ),
        labelSmall: baseTextTheme.labelSmall?.copyWith(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w500,
          color: AppColors.neutralTextSecondary,
        ),
      ),
    );
  }

  /// Estilo custom para el timer grande (no forma parte del TextTheme estándar).
  static TextStyle timerTextStyle(BuildContext context) {
    return GoogleFonts.roboto(
      fontSize: 64,
      fontWeight: FontWeight.w700,
      letterSpacing: -1,
      color: AppColors.neutralTextPrimary,
    );
  }
}
