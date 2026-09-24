import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/state/pomodoro_controller.dart';

void main() {
  group('PomodoroController', () {
    test('arranca en enfoque, ciclo 1, con el tiempo completo', () {
      final controller = PomodoroController();
      addTearDown(controller.dispose);

      expect(controller.phase, SessionPhase.focus);
      expect(controller.currentCycle, 1);
      expect(controller.formattedTime, '25:00');
      expect(controller.progress, 0);
      expect(controller.isRunning, isFalse);
    });

    test('descuenta el tiempo mientras corre', () {
      fakeAsync((async) {
        final controller = PomodoroController();
        addTearDown(controller.dispose);

        controller.start();
        expect(controller.isRunning, isTrue);

        async.elapse(const Duration(minutes: 1));
        expect(controller.formattedTime, '24:00');
        expect(controller.progress, closeTo(1 / 25, 0.001));
      });
    });

    test('pause congela el conteo y resume lo retoma', () {
      fakeAsync((async) {
        final controller = PomodoroController();
        addTearDown(controller.dispose);

        controller.start();
        async.elapse(const Duration(minutes: 5));
        controller.pause();

        async.elapse(const Duration(minutes: 10));
        expect(controller.formattedTime, '20:00',
            reason: 'en pausa el tiempo no debe correr');
        expect(controller.isRunning, isFalse);

        controller.resume();
        async.elapse(const Duration(minutes: 2));
        expect(controller.formattedTime, '18:00');
      });
    });

    test('al terminar el enfoque pasa a descanso', () {
      fakeAsync((async) {
        final controller = PomodoroController();
        addTearDown(controller.dispose);

        controller.start();
        async.elapse(controller.focusDuration);

        expect(controller.phase, SessionPhase.breakTime);
        expect(controller.currentCycle, 1);
        expect(controller.formattedTime, '05:00');
      });
    });

    test('skipBreak avanza al siguiente ciclo y cuenta el descanso', () {
      fakeAsync((async) {
        final controller = PomodoroController();
        addTearDown(controller.dispose);

        controller.start();
        async.elapse(controller.focusDuration);
        controller.skipBreak();

        expect(controller.phase, SessionPhase.focus);
        expect(controller.currentCycle, 2);
        expect(controller.completedBreaks, 1);
        expect(controller.formattedTime, '25:00');
      });
    });

    test('la sesión completa termina en 1h 15m / 3/3 / 3', () {
      fakeAsync((async) {
        final controller = PomodoroController();
        addTearDown(controller.dispose);

        controller.start();
        for (var i = 0; i < PomodoroController.totalCycles; i++) {
          async.elapse(controller.focusDuration);
          async.elapse(controller.breakDuration);
        }

        expect(controller.phase, SessionPhase.finished);
        expect(controller.completedFully, isTrue);
        expect(controller.isRunning, isFalse);
        expect(controller.totalFocusFormatted, '1h 15m');
        expect(controller.cyclesLabel, '3/3');
        expect(controller.breaksLabel, '3');
      });
    });

    test('finishEarly cierra como parcial contando el enfoque transcurrido', () {
      fakeAsync((async) {
        final controller = PomodoroController();
        addTearDown(controller.dispose);

        controller.start();
        async.elapse(const Duration(minutes: 10));
        controller.finishEarly();

        expect(controller.phase, SessionPhase.finished);
        expect(controller.completedFully, isFalse);
        expect(controller.cyclesLabel, '0/3');
        expect(controller.totalFocusFormatted, '10m');
      });
    });

    test('reset vuelve al ciclo 1 y deja el timer corriendo', () {
      fakeAsync((async) {
        final controller = PomodoroController();
        addTearDown(controller.dispose);

        controller.start();
        async.elapse(controller.focusDuration);
        controller.skipBreak();
        controller.reset();

        expect(controller.phase, SessionPhase.focus);
        expect(controller.currentCycle, 1);
        expect(controller.completedBreaks, 0);
        expect(controller.formattedTime, '25:00');
        expect(controller.isRunning, isTrue);
      });
    });
  });
}
