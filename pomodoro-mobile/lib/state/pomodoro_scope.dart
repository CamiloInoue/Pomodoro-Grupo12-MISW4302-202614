import 'package:flutter/widgets.dart';

import 'pomodoro_controller.dart';

/// Expone el [PomodoroController] al árbol de widgets.
///
/// Al ser un [InheritedNotifier], los descendientes que llaman
/// [PomodoroScope.of] se reconstruyen solos cada vez que el controlador
/// notifica un cambio.
class PomodoroScope extends InheritedNotifier<PomodoroController> {
  const PomodoroScope({
    super.key,
    required PomodoroController controller,
    required super.child,
  }) : super(notifier: controller);

  static PomodoroController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<PomodoroScope>();
    assert(scope != null, 'No se encontró un PomodoroScope en el árbol.');
    return scope!.notifier!;
  }
}
