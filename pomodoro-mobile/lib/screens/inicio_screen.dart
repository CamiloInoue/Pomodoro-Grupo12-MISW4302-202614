import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_screen_body.dart';
import '../widgets/bottom_nav_bar.dart';
import 'seleccionar_tarea_screen.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(activeTab: NavTab.inicio),
      body: AppScreenBody(
        bottom: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SeleccionarTareaScreen()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.flowConfig,
                foregroundColor: AppColors.neutralBackground,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Nueva sesión', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.flowRepeatExtend,
                side: const BorderSide(color: AppColors.flowRepeatExtend, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Repetir última sesión', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        children: [
          const Text('Inicio', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.neutralTextPrimary)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.neutralSurface,
              border: Border.all(color: AppColors.neutralBorder),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ACTIVIDAD RECIENTE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.neutralTextSecondary)),
                SizedBox(height: 8),
                Text('Terminar Ensayo', style: TextStyle(fontSize: 16, color: AppColors.neutralTextPrimary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}