import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/main.dart';

void main() {
  testWidgets('la app abre en la pantalla de enfoque activo',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PomodoroApp());

    expect(find.text('Enfoque activo'), findsOneWidget);
    expect(find.text('25:00'), findsOneWidget);
    expect(find.text('Terminar ensayo · Ciclo 1 de 3'), findsOneWidget);
    expect(find.text('⏸ Pausar'), findsOneWidget);
  });

  testWidgets('el botón Pausar alterna a Reanudar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PomodoroApp());

    await tester.tap(find.text('⏸ Pausar'));
    await tester.pump();

    expect(find.text('▶ Reanudar'), findsOneWidget);
    expect(find.text('⏸ Pausar'), findsNothing);
  });

  testWidgets('Finalizar lleva al resumen marcado como parcial',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PomodoroApp());

    await tester.tap(find.text('✕ Finalizar'));
    await tester.pump();

    expect(find.text('Resumen de sesión'), findsOneWidget);
    expect(find.text('SESIÓN PARCIAL'), findsOneWidget);
    expect(find.text('0/3'), findsOneWidget);
  });
}
