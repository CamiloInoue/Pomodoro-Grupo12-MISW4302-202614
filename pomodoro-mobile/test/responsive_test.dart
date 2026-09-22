import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/screens/break_screen.dart';
import 'package:pomodoro/screens/focus_active_screen.dart';
import 'package:pomodoro/screens/session_summary_screen.dart';
import 'package:pomodoro/theme/app_theme.dart';

/// Tamaños representativos, en dp lógicos.
const _viewports = <String, Size>{
  'teléfono angosto (320x480)': Size(320, 480),
  'teléfono típico (412x891)': Size(412, 891),
  'teléfono horizontal (891x412)': Size(891, 412),
  'tablet (768x1024)': Size(768, 1024),
  'escritorio (1440x900)': Size(1440, 900),
  'ventana muy baja (1280x320)': Size(1280, 320),
};

final _screens = <String, Widget>{
  'FocusActiveScreen': const FocusActiveScreen(
    activityName: 'Terminar ensayo',
    currentCycle: 1,
    totalCycles: 3,
    timeRemaining: '18:42',
    progress: 0.35,
  ),
  'BreakScreen': const BreakScreen(
    currentCycle: 1,
    totalCycles: 3,
    timeRemaining: '04:12',
    progress: 0.65,
  ),
  'SessionSummaryScreen': const SessionSummaryScreen(
    totalTime: '1h 15m',
    cyclesCompleted: '3/3',
    breaksCount: '3',
  ),
};

Future<void> _pumpAt(WidgetTester tester, Widget screen, Size size) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(theme: AppTheme.theme, home: screen),
  );
}

void main() {
  group('ninguna pantalla desborda', () {
    for (final screen in _screens.entries) {
      for (final viewport in _viewports.entries) {
        testWidgets('${screen.key} en ${viewport.key}',
            (WidgetTester tester) async {
          await _pumpAt(tester, screen.value, viewport.value);

          // Un RenderFlex overflow se reporta como excepción capturada.
          expect(tester.takeException(), isNull);
        });
      }
    }
  });

  group('el contenido se limita y centra en pantallas anchas', () {
    testWidgets('en escritorio no ocupa todo el ancho de la ventana',
        (WidgetTester tester) async {
      await _pumpAt(tester, _screens['FocusActiveScreen']!, const Size(1440, 900));

      final card = tester.getSize(
        find.ancestor(
          of: find.text('Modo concentración activado'),
          matching: find.byType(Container),
        ).first,
      );

      expect(card.width, lessThanOrEqualTo(AppTheme.maxContentWidth));
    });

    testWidgets('en un teléfono sí usa el ancho disponible',
        (WidgetTester tester) async {
      await _pumpAt(tester, _screens['FocusActiveScreen']!, const Size(412, 891));

      final card = tester.getSize(
        find.ancestor(
          of: find.text('Modo concentración activado'),
          matching: find.byType(Container),
        ).first,
      );

      // 412 menos los 16dp de padding a cada lado.
      expect(card.width, 412 - 32);
    });
  });

  group('el contenido hace scroll cuando no cabe', () {
    testWidgets('en una ventana baja aparece un scroll view utilizable',
        (WidgetTester tester) async {
      await _pumpAt(tester, _screens['FocusActiveScreen']!, const Size(412, 320));

      final scrollable = find.byType(Scrollable);
      expect(scrollable, findsOneWidget);

      final position = tester.state<ScrollableState>(scrollable).position;
      expect(position.maxScrollExtent, greaterThan(0),
          reason: 'debe poder desplazarse para alcanzar todo el contenido');
    });

    testWidgets('los botones siguen visibles aunque el contenido desborde',
        (WidgetTester tester) async {
      await _pumpAt(tester, _screens['FocusActiveScreen']!, const Size(412, 320));

      expect(find.text('⏸ Pausar'), findsOneWidget);
      expect(find.text('✕ Finalizar'), findsOneWidget);
      expect(tester.getBottomRight(find.text('✕ Finalizar')).dy,
          lessThanOrEqualTo(320));
    });
  });
}
