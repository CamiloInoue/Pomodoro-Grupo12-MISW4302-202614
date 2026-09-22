import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_screen_body.dart';
import '../widgets/bottom_nav_bar.dart';

/// Pantalla 12: Resumen de sesión (completa)
/// Flujo: Cierre (verde #22C55E)
class SessionSummaryScreen extends StatelessWidget {
  final String totalTime;
  final String cyclesCompleted;
  final String breaksCount;

  /// `false` cuando la sesión se cortó con "Finalizar": cambia el badge al
  /// tono de finalización anticipada en lugar del verde de cierre.
  final bool isComplete;
  final VoidCallback? onViewHistoryTap;
  final VoidCallback? onBackToHomeTap;
  final ValueChanged<NavTab>? onTabSelected;

  const SessionSummaryScreen({
    super.key,
    required this.totalTime,
    required this.cyclesCompleted,
    required this.breaksCount,
    this.isComplete = true,
    this.onViewHistoryTap,
    this.onBackToHomeTap,
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreenBody(
        bottom: BottomNavBar(
          activeTab: NavTab.inicio,
          onTabSelected: onTabSelected,
        ),
        children: [
          // Header
          Row(
            children: [
              Text(
                isComplete ? '✓' : '!',
                style: TextStyle(
                  fontSize: 20,
                  color: isComplete
                      ? AppColors.flowClosure
                      : AppColors.flowEarlyFinish,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Resumen de sesión',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Badge "SESIÓN COMPLETA" / "SESIÓN PARCIAL"
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isComplete
                  ? AppColors.closureContainer
                  : AppColors.earlyFinishContainer,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              isComplete ? 'SESIÓN COMPLETA' : 'SESIÓN PARCIAL',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isComplete
                        ? AppColors.closureOnContainer
                        : AppColors.earlyFinishOnContainer,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 16),

          // 3 stat cards: en fila si hay ancho, apiladas si la pantalla es muy
          // angosta (el Row las dejaría ilegibles por debajo de ~320dp).
          LayoutBuilder(
            builder: (context, constraints) {
              final cards = [
                _StatCard(value: totalTime, label: 'Tiempo total'),
                _StatCard(value: cyclesCompleted, label: 'Ciclos'),
                _StatCard(value: breaksCount, label: 'Descansos'),
              ];

              if (constraints.maxWidth < 280) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final card in cards) ...[
                      card,
                      if (card != cards.last) const SizedBox(height: 8),
                    ],
                  ],
                );
              }

              // IntrinsicHeight acota la altura de la fila a la de la tarjeta
              // más alta: sin él, `stretch` pide altura infinita dentro del
              // área desplazable y la pantalla no puede hacer layout.
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final card in cards) ...[
                      Expanded(child: card),
                      if (card != cards.last) const SizedBox(width: 8),
                    ],
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: onViewHistoryTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.flowClosure,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size.fromHeight(40),
              elevation: 0,
            ),
            child: const Text('Ver historial'),
          ),
          const SizedBox(height: 8),

          OutlinedButton(
            onPressed: onBackToHomeTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.neutralTextPrimary,
              side: const BorderSide(color: AppColors.neutralBorder, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size.fromHeight(40),
            ),
            child: const Text('Volver al inicio'),
          ),
          const SizedBox(height: 16),

          Text(
            '⭐ retroalimentación del sistema: resultado final de la sesión completa, distinto de una parcial',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutralBorder, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
