import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/app_screen_body.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/progress_dots.dart';

/// Pantalla 07: Descanso
/// Flujo: Enfoque (ámbar #F59E0B)
class BreakScreen extends StatelessWidget {
  final int currentCycle;
  final int totalCycles;
  final String timeRemaining;
  final double progress;
  final VoidCallback? onSkipBreakTap;
  final ValueChanged<NavTab>? onTabSelected;

  const BreakScreen({
    super.key,
    required this.currentCycle,
    required this.totalCycles,
    required this.timeRemaining,
    required this.progress,
    this.onSkipBreakTap,
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreenBody(
        bottom: BottomNavBar(
          activeTab: NavTab.historial,
          onTabSelected: onTabSelected,
        ),
        children: [
          // Header con ícono de taza
          Row(
            children: [
              const Text('☕', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                'Descanso',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress dots (completados en ámbar)
          ProgressDots(
            totalCycles: totalCycles,
            currentCycle: currentCycle,
            completedCycles: currentCycle,
            activeColor: AppColors.flowFocus,
          ),
          const SizedBox(height: 24),

          // Timer
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              timeRemaining,
              textAlign: TextAlign.center,
              style: AppTheme.timerTextStyle(context),
            ),
          ),
          const SizedBox(height: 8),

          Text(
            'Ciclo $currentCycle de $totalCycles completado',
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
              valueColor: const AlwaysStoppedAnimation(AppColors.flowFocus),
            ),
          ),
          const SizedBox(height: 16),

          OutlinedButton(
            onPressed: onSkipBreakTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.neutralTextPrimary,
              side: const BorderSide(color: AppColors.neutralBorder, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size.fromHeight(40),
            ),
            child: const Text(
              '⏭ Saltar descanso',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
