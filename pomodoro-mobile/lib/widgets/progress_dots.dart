import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Dots de progreso de ciclos (custom, no existe nativo en Material).
class ProgressDots extends StatelessWidget {
  final int totalCycles;
  final int currentCycle;
  final int completedCycles;
  final Color activeColor;

  const ProgressDots({
    super.key,
    required this.totalCycles,
    required this.currentCycle,
    this.completedCycles = 0,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (int i = 1; i <= totalCycles; i++) {
      final isFilled = i <= completedCycles || i == currentCycle;

      children.add(
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled ? activeColor : Colors.transparent,
            border: isFilled ? null : Border.all(color: AppColors.neutralBorder, width: 1.5),
          ),
        ),
      );

      if (i < totalCycles) {
        children.add(
          Container(
            width: 12,
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.neutralBorder, width: 1, style: BorderStyle.solid),
              ),
            ),
          ),
        );
      }
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }
}
