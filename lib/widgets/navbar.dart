import 'package:flutter/material.dart';

import '../themes/colors/colors.dart';

class ReNavbar extends StatelessWidget {
  final int index;
  final Color selectedColor;
  final Color unselectedColor;
  final Function(int)? onTap;
  final Color backgroundColor;
  final List<BottomNavigationBarItem> items;
  const ReNavbar({
    super.key,
    required this.index,
    this.selectedColor = ColorsTheme.secondary,
    this.unselectedColor = ColorsTheme.disabled,
    required this.onTap,
    required this.items,
    this.backgroundColor = ColorsTheme.primary,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: backgroundColor,
      currentIndex: index,
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
      onTap: onTap,
      items: items,
    );
  }
}
