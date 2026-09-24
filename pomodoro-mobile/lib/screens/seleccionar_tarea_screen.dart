import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_screen_body.dart';
import '../widgets/bottom_nav_bar.dart';
import 'configurar_pomodoro_screen.dart';

class SeleccionarTareaScreen extends StatelessWidget {
  const SeleccionarTareaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.neutralBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.neutralTextPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(activeTab: NavTab.inicio),
      body: AppScreenBody(
        bottom: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.flowConfig,
                  side: const BorderSide(color: AppColors.flowConfig, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Nueva actividad', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ConfigurarPomodoroScreen()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.flowConfig,
                  foregroundColor: AppColors.neutralBackground,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Continuar', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
        children: [
          const Text('Seleccionar tarea', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.neutralTextPrimary)),
          const SizedBox(height: 24),
          _buildTaskItem('Terminar Ensayo', isSelected: true),
          const SizedBox(height: 12),
          _buildTaskItem('Estudiar Cálculo'),
          const SizedBox(height: 12),
          _buildTaskItem('Leer Capítulo 4'),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String title, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.flowConfig.withValues(alpha: 0.05) : AppColors.neutralBackground,
        border: Border.all(color: isSelected ? AppColors.flowConfig : AppColors.neutralBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, color: isSelected ? AppColors.flowConfig : AppColors.neutralTextPrimary),
      ),
    );
  }
}