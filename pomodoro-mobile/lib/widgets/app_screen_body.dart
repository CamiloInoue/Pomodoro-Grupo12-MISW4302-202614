import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Cuerpo común de las pantallas, adaptable a cualquier tamaño de viewport.
///
/// Resuelve dos problemas del diseño original:
///
/// * En web/escritorio el contenido se limita a [AppTheme.maxContentWidth] y se
///   centra, en vez de estirarse a todo el ancho de la ventana.
/// * [children] va en un área desplazable y [bottom] queda fijo al fondo. Así
///   una ventana baja o un teléfono en horizontal hacen scroll en lugar de
///   provocar un overflow del `Column` (que es lo que pasaba con `Spacer`).
class AppScreenBody extends StatelessWidget {
  /// Contenido principal, desplazable si no cabe.
  final List<Widget> children;

  /// Acciones fijas al fondo (botones o barra de navegación).
  final Widget? bottom;

  const AppScreenBody({
    super.key,
    required this.children,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Ancho fijo (no solo máximo) para que crossAxisAlignment.stretch
          // siga estirando los botones a todo el ancho del contenido.
          final width = math.min(constraints.maxWidth, AppTheme.maxContentWidth);

          return Center(
            child: SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: children,
                        ),
                      ),
                    ),
                    if (bottom != null) ...[
                      const SizedBox(height: 16),
                      bottom!,
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
