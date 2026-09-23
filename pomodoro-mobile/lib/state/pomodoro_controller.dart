import 'dart:async';

import 'package:clock/clock.dart';

import 'package:flutter/foundation.dart';

/// Fase actual del flujo de Enfoque.
enum SessionPhase { focus, breakTime, finished }

/// Controla el temporizador y las estadísticas de una sesión Pomodoro.
///
/// El tiempo restante se calcula siempre contra el reloj de pared (`_deadline`)
/// y nunca acumulando ticks: si el sistema operativo estrangula los timers con
/// la app en segundo plano, al volver el conteo sigue siendo correcto.
class PomodoroController extends ChangeNotifier {
  static const focusDuration = Duration(minutes: 1);
  static const breakDuration = Duration(minutes: 1);
  static const totalCycles = 3;

  /// Provisional hasta que exista la pantalla de Configuración.
  static const activityName = 'Terminar ensayo';

  Timer? _ticker;
  DateTime _deadline = clock.now();

  SessionPhase _phase = SessionPhase.focus;
  int _currentCycle = 1;
  int _cyclesCompleted = 0;
  int _completedBreaks = 0;
  Duration _remaining = focusDuration;
  Duration _focusElapsed = Duration.zero;
  bool _isRunning = false;
  bool _completedFully = false;

  SessionPhase get phase => _phase;
  int get currentCycle => _currentCycle;
  int get completedBreaks => _completedBreaks;
  bool get isRunning => _isRunning;
  bool get completedFully => _completedFully;
  Duration get remaining => _remaining;
  Duration get focusElapsed => _focusElapsed;

  Duration get _phaseDuration {
    switch (_phase) {
      case SessionPhase.focus:
        return focusDuration;
      case SessionPhase.breakTime:
        return breakDuration;
      case SessionPhase.finished:
        return Duration.zero;
    }
  }

  /// Tiempo transcurrido dentro de la fase actual.
  Duration get _elapsedInPhase => _phaseDuration - _remaining;

  /// Avance de la fase actual, entre 0 y 1.
  double get progress {
    final total = _phaseDuration.inMilliseconds;
    if (total <= 0) return 1;
    return (_elapsedInPhase.inMilliseconds / total).clamp(0.0, 1.0);
  }

  /// Tiempo restante en formato `mm:ss`.
  String get formattedTime {
    final seconds = (_remaining.inMilliseconds / 1000).ceil().clamp(0, 1 << 31);
    final minutes = seconds ~/ 60;
    return '${_twoDigits(minutes)}:${_twoDigits(seconds % 60)}';
  }

  /// Tiempo total de enfoque acumulado, p. ej. `1h 15m`.
  String get totalFocusFormatted {
    final minutes = _focusElapsed.inMinutes;
    final hours = minutes ~/ 60;
    if (hours == 0) return '${minutes}m';
    return '${hours}h ${minutes % 60}m';
  }

  String get cyclesLabel => '$_cyclesCompleted/$totalCycles';

  String get breaksLabel => '$_completedBreaks';

  static String _twoDigits(int value) => value.toString().padLeft(2, '0');

  /// Arranca o reanuda el conteo. No hace nada si la sesión ya terminó.
  void start() {
    if (_isRunning || _phase == SessionPhase.finished) return;
    _isRunning = true;
    _restartDeadline();
    _ticker = Timer.periodic(const Duration(seconds: 1), _tick);
    notifyListeners();
  }

  /// Congela el conteo dejando `_remaining` en su valor exacto.
  void pause() {
    if (!_isRunning) return;
    _ticker?.cancel();
    _ticker = null;
    _remaining = _deadline.difference(clock.now());
    if (_remaining < Duration.zero) _remaining = Duration.zero;
    _isRunning = false;
    notifyListeners();
  }

  void resume() => start();

  void toggleRunning() => _isRunning ? pause() : start();

  /// Termina el descanso en curso; cuenta como descanso tomado.
  void skipBreak() {
    if (_phase != SessionPhase.breakTime) return;
    _closeBreak();
    notifyListeners();
  }

  /// Corta la sesión antes de tiempo: el resumen se marca como parcial.
  void finishEarly() {
    if (_phase == SessionPhase.finished) return;
    if (_phase == SessionPhase.focus) {
      _focusElapsed += _elapsedInPhase;
    }
    _finish(completed: false);
    notifyListeners();
  }

  /// Vuelve al inicio: ciclo 1, enfoque completo, estadísticas en cero.
  void reset() {
    _ticker?.cancel();
    _ticker = null;
    _isRunning = false;
    _phase = SessionPhase.focus;
    _currentCycle = 1;
    _cyclesCompleted = 0;
    _completedBreaks = 0;
    _remaining = focusDuration;
    _focusElapsed = Duration.zero;
    _completedFully = false;
    start();
  }

  void _tick(Timer _) {
    _remaining = _deadline.difference(clock.now());
    if (_remaining <= Duration.zero) {
      _remaining = Duration.zero;
      _advance();
    }
    notifyListeners();
  }

  /// Transición al terminar la fase actual:
  /// focus(n) -> descanso(n) -> focus(n+1) ... y tras el descanso del último
  /// ciclo, la sesión se cierra como completa.
  void _advance() {
    if (_phase == SessionPhase.focus) {
      _focusElapsed += focusDuration;
      _phase = SessionPhase.breakTime;
      _remaining = breakDuration;
      _restartDeadline();
    } else if (_phase == SessionPhase.breakTime) {
      _closeBreak();
    }
  }

  void _closeBreak() {
    _completedBreaks++;
    _cyclesCompleted++;
    if (_currentCycle >= totalCycles) {
      _finish(completed: true);
    } else {
      _currentCycle++;
      _phase = SessionPhase.focus;
      _remaining = focusDuration;
      _restartDeadline();
    }
  }

  void _finish({required bool completed}) {
    _ticker?.cancel();
    _ticker = null;
    _isRunning = false;
    _phase = SessionPhase.finished;
    _remaining = Duration.zero;
    _completedFully = completed;
  }

  void _restartDeadline() => _deadline = clock.now().add(_remaining);

  @override
  void dispose() {
    _ticker?.cancel();
    _ticker = null;
    super.dispose();
  }
}
