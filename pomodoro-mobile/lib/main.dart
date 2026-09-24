import 'package:flutter/material.dart';

import 'screens/break_screen.dart';
import 'screens/focus_active_screen.dart';
import 'screens/session_summary_screen.dart';
import 'screens/inicio_screen.dart';
import 'screens/seleccionar_tarea_screen.dart';
import 'screens/configurar_pomodoro_screen.dart';
import 'state/pomodoro_controller.dart';
import 'state/pomodoro_scope.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PomodoroApp());
}

/// Raíz de la app: es dueña del [PomodoroController] y lo expone al árbol.
class PomodoroApp extends StatefulWidget {
  const PomodoroApp({super.key});

  @override
  State<PomodoroApp> createState() => _PomodoroAppState();
}

class _PomodoroAppState extends State<PomodoroApp> {
  late final PomodoroController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PomodoroController();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PomodoroScope(
      controller: _controller,
      child: MaterialApp(
        title: 'Pomodoro App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const InicioScreen(),
      ),
    );
  }
}

/// Renderiza la pantalla que corresponde a la fase actual de la sesión.
///
/// La fase la manda el controlador, no el [Navigator]: por eso no hay rutas
/// nombradas para /focus, /break y /summary.
class SessionFlowScreen extends StatelessWidget {
  const SessionFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PomodoroScope.of(context);

    switch (controller.phase) {
      case SessionPhase.focus:
        return FocusActiveScreen(
          activityName: PomodoroController.activityName,
          currentCycle: controller.currentCycle,
          totalCycles: PomodoroController.totalCycles,
          timeRemaining: controller.formattedTime,
          progress: controller.progress,
          isPaused: !controller.isRunning,
          onPauseTap: controller.toggleRunning,
          onFinishTap: controller.finishEarly,
        );
      case SessionPhase.breakTime:
        return BreakScreen(
          currentCycle: controller.currentCycle,
          totalCycles: PomodoroController.totalCycles,
          timeRemaining: controller.formattedTime,
          progress: controller.progress,
          onSkipBreakTap: controller.skipBreak,
        );
      case SessionPhase.finished:
        return SessionSummaryScreen(
          totalTime: controller.totalFocusFormatted,
          cyclesCompleted: controller.cyclesLabel,
          breaksCount: controller.breaksLabel,
          isComplete: controller.completedFully,
          onBackToHomeTap: () {
            controller.reset();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const InicioScreen()),
              (route) => false,
            );
          },
        );
    }
  }
}
