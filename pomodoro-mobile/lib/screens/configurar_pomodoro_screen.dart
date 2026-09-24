import 'package:flutter/material.dart';
import '../main.dart';
import '../state/pomodoro_scope.dart';
import '../theme/app_colors.dart';
import '../widgets/app_screen_body.dart';
import '../widgets/bottom_nav_bar.dart';

class ConfigurarPomodoroScreen extends StatefulWidget {
  const ConfigurarPomodoroScreen({super.key});

  @override
  State<ConfigurarPomodoroScreen> createState() =>
      _ConfigurarPomodoroScreenState();
}

class _ConfigurarPomodoroScreenState extends State<ConfigurarPomodoroScreen> {
  static const _focusStep = 5;
  static const _focusMin = 5;
  static const _focusMax = 3600;
  static const _breakStep = 5;
  static const _breakMin = 5;
  static const _breakMax = 1800;

  int _focusSeconds = 30;
  int _breakSeconds = 5;

  void _changeFocus(int delta) {
    setState(() {
      _focusSeconds = (_focusSeconds + delta).clamp(_focusMin, _focusMax);
    });
  }

  void _changeBreak(int delta) {
    setState(() {
      _breakSeconds = (_breakSeconds + delta).clamp(_breakMin, _breakMax);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.neutralBackground,
        elevation: 0,
        automaticallyImplyLeading:
            false, // El mockup no muestra flecha de regreso aquí
      ),
      bottomNavigationBar: const BottomNavBar(activeTab: NavTab.inicio),
      body: AppScreenBody(
        bottom: ElevatedButton(
          onPressed: () {
            // Disparamos el reloj aquí, justo en el momento en que el usuario decide arrancar
            PomodoroScope.of(context).configure(
              focusDuration: Duration(seconds: _focusSeconds),
              breakDuration: Duration(seconds: _breakSeconds),
            );
            PomodoroScope.of(context).start();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SessionFlowScreen()),
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.flowConfig,
            foregroundColor: AppColors.neutralBackground,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Iniciar',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        children: [
          const Text(
            'Configurar pomodoro',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.neutralTextPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Actividad seleccionada: Terminar ensayo',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.neutralTextSecondary,
            ),
          ),
          const SizedBox(height: 32),
          _buildStepper(
            'Tiempo concentración: $_focusSeconds seg',
            onDecrement: _focusSeconds > _focusMin
                ? () => _changeFocus(-_focusStep)
                : null,
            onIncrement: _focusSeconds < _focusMax
                ? () => _changeFocus(_focusStep)
                : null,
          ),
          const SizedBox(height: 16),
          _buildStepper(
            'Tiempo descanso: $_breakSeconds seg',
            onDecrement: _breakSeconds > _breakMin
                ? () => _changeBreak(-_breakStep)
                : null,
            onIncrement: _breakSeconds < _breakMax
                ? () => _changeBreak(_breakStep)
                : null,
          ),
          const SizedBox(height: 32),
          const Text(
            'Número de ciclos',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.neutralTextSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildCycleChip('1', false),
              const SizedBox(width: 8),
              _buildCycleChip('2', false),
              const SizedBox(width: 8),
              _buildCycleChip('3', true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepper(
    String label, {
    required VoidCallback? onDecrement,
    required VoidCallback? onIncrement,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutralBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.neutralTextPrimary,
            ),
          ),
          Row(
            children: [
              _iconButton(Icons.remove, onTap: onDecrement),
              const SizedBox(width: 8),
              _iconButton(Icons.add, isAccent: true, onTap: onIncrement),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconButton(
    IconData icon, {
    bool isAccent = false,
    required VoidCallback? onTap,
  }) {
    final isEnabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(
            color: isAccent && isEnabled
                ? AppColors.flowConfig
                : AppColors.neutralBorder,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isAccent && isEnabled
              ? AppColors.flowConfig.withValues(alpha: 0.1)
              : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: 16,
          color: !isEnabled
              ? AppColors.neutralBorder
              : isAccent
                  ? AppColors.flowConfig
                  : AppColors.neutralTextPrimary,
        ),
      ),
    );
  }

  Widget _buildCycleChip(String label, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.flowConfig : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.flowConfig : AppColors.neutralBorder,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? AppColors.neutralBackground
                : AppColors.neutralTextPrimary,
          ),
        ),
      ),
    );
  }
}
