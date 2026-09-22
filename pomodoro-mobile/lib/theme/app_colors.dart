import 'package:flutter/material.dart';

/// Colores del Style Tile del proyecto Pomodoro.
class AppColors {
  AppColors._();

  // Colores por flujo
  static const flowConfig = Color(0xFF2563EB); // Configuración
  static const flowFocus = Color(0xFFF59E0B); // Enfoque activo
  static const flowInterrupt = Color(0xFF8B5CF6); // Pausa / Interrupción
  static const flowEarlyFinish = Color(0xFFEF4444); // Finalización anticipada
  static const flowClosure = Color(0xFF22C55E); // Cierre / Resumen
  static const flowRepeatExtend = Color(0xFF14B8A6); // Repetir / Extender

  // Neutros
  static const neutralBackground = Color(0xFFFFFFFF);
  static const neutralSurface = Color(0xFFF5F5F7);
  static const neutralTextPrimary = Color(0xFF1C1B1F);
  static const neutralTextSecondary = Color(0xFF49454F);
  static const neutralBorder = Color(0xFFCAC4D0);

  // Contenedores tonales para badges
  static const closureContainer = Color(0xFFDCFCE7);
  static const closureOnContainer = Color(0xFF15803D);
  static const earlyFinishContainer = Color(0xFFFEE2E2);
  static const earlyFinishOnContainer = Color(0xFFB91C1C);

  static const progressTrack = Color(0xFFE6E0E9);
}
