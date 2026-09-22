import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Tema Material 3 configurado con los colores y tipografía del Style Tile.
class AppTheme {
  AppTheme._();

  /// Ancho máximo del contenido. En un teléfono no se nota (las pantallas son
  /// más angostas); en web evita que todo se estire a lo ancho del monitor.
  static const double maxContentWidth = 480;

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
        error: AppColors.flowEarlyFinish,
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
  ///
  /// El tamaño se adapta al viewport: se limita por el ancho del contenido y
  /// también por el alto, para que en horizontal o en una ventana baja el
  /// número no se coma la pantalla. En un teléfono de 412x891 da ~64, que es
  /// el valor del Style Tile.
  static TextStyle timerTextStyle(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final byWidth = math.min(size.width, maxContentWidth) * 0.155;
    final byHeight = size.height * 0.14;
    final fontSize = math.min(byWidth, byHeight).clamp(36.0, 72.0);

    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      letterSpacing: -1,
      color: AppColors.neutralTextPrimary,
    );
  }
}
