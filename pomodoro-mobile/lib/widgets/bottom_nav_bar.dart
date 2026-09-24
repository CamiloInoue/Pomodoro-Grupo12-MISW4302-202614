import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum NavTab { inicio, historial, ajustes }

extension NavTabLabel on NavTab {
  String get label {
    switch (this) {
      case NavTab.inicio:
        return 'Inicio';
      case NavTab.historial:
        return 'Historial';
      case NavTab.ajustes:
        return 'Ajustes';
    }
  }

  IconData get icon {
    switch (this) {
      case NavTab.inicio:
        return Icons.home_outlined;
      case NavTab.historial:
        return Icons.history;
      case NavTab.ajustes:
        return Icons.settings_outlined;
    }
  }

  IconData get activeIcon {
    switch (this) {
      case NavTab.inicio:
        return Icons.home;
      case NavTab.historial:
        return Icons.history;
      case NavTab.ajustes:
        return Icons.settings;
    }
  }
}

/// Tab bar inferior reutilizable (custom, sigue el spec de 80dp de altura).
class BottomNavBar extends StatelessWidget {
  final NavTab activeTab;
  final ValueChanged<NavTab>? onTabSelected;

  const BottomNavBar({
    super.key,
    required this.activeTab,
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: AppColors.neutralBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: NavTab.values.map((tab) {
          final isActive = tab == activeTab;
          return GestureDetector(
            onTap: () => onTabSelected?.call(tab),
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  Icon(
                    isActive ? tab.activeIcon : tab.icon,
                    size: 22,
                    color: isActive
                        ? AppColors.neutralTextPrimary
                        : AppColors.neutralTextSecondary,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tab.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isActive
                          ? AppColors.neutralTextPrimary
                          : AppColors.neutralTextSecondary,
                    ),
                  ),
                  if (isActive) ...[
                    const SizedBox(height: 4),
                    Container(
                      width: 32,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.neutralTextPrimary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
