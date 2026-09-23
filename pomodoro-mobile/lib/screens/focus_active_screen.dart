import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/app_screen_body.dart';
import '../widgets/progress_dots.dart';

/// Pantalla 05: Enfoque activo
/// Flujo: Enfoque (ámbar #F59E0B)
class FocusActiveScreen extends StatelessWidget {
  final String activityName;
  final int currentCycle;
  final int totalCycles;
  final String timeRemaining;
  final double progress;
  final bool isPaused;
  final VoidCallback? onPauseTap;
  final VoidCallback? onFinishTap;

  const FocusActiveScreen({
    super.key,
    required this.activityName,
    required this.currentCycle,
    required this.totalCycles,
    required this.timeRemaining,
    required this.progress,
    this.isPaused = false,
    this.onPauseTap,
    this.onFinishTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreenBody(
        // Botones Pausar / Finalizar
        bottom: Row(
          children: [
            Expanded(
              child: isPaused
                  ? ElevatedButton(
                      onPressed: onPauseTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.flowInterrupt,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size.fromHeight(40),
                        elevation: 0,
                      ),
                      child: const Text(
                        '▶ Reanudar',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : OutlinedButton(
                      onPressed: onPauseTap,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.neutralTextPrimary,
                        side: const BorderSide(color: AppColors.neutralBorder, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size.fromHeight(40),
                      ),
                      child: const Text(
                        '⏸ Pausar',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: onFinishTap,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.neutralTextPrimary,
                  side: const BorderSide(color: AppColors.neutralBorder, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text(
                  '✕ Finalizar',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        children: [
          // Badge "Enfoque activo" (+ "En pausa" cuando corresponde)
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.flowFocus,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Enfoque activo',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.flowFocus,
                    ),
              ),
              if (isPaused) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.interruptContainer,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'En pausa',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.interruptOnContainer,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Progress dots
          ProgressDots(
            totalCycles: totalCycles,
            currentCycle: currentCycle,
            activeColor: isPaused ? AppColors.flowInterrupt : AppColors.flowFocus,
          ),
          const SizedBox(height: 24),

          // Timer grande
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              timeRemaining,
              textAlign: TextAlign.center,
              style: AppTheme.timerTextStyle(context),
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            '$activityName · Ciclo $currentCycle de $totalCycles',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 16),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.progressTrack,
              valueColor: AlwaysStoppedAnimation(
                isPaused ? AppColors.flowInterrupt : AppColors.flowFocus,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Card "Modo concentración activado"
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.neutralBorder, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Modo concentración activado',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
