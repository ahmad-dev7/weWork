import 'package:flutter/material.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

SalomonBottomBarItem kGetBottomBarItems(
    {required IconData icon,
    required String text,
    required IconData activeIcon}) {
  return SalomonBottomBarItem(
    icon: Icon(icon),
    title: KMyText(text, color: accentColor),
    activeIcon: Icon(activeIcon),
    selectedColor: accentColor,
    unselectedColor: Colors.black54,
  );
}

List<SalomonBottomBarItem> kBottomBarItems() {
  return [
    kGetBottomBarItems(
      icon: Icons.home_outlined,
      text: 'Home',
      activeIcon: Icons.home_filled,
    ),
    kGetBottomBarItems(
      icon: Icons.chat_outlined,
      text: 'Chat',
      activeIcon: Icons.chat,
    ),
    kGetBottomBarItems(
      icon: Icons.file_copy_outlined,
      text: 'Document',
      activeIcon: Icons.file_copy,
    ),
    kGetBottomBarItems(
      icon: Icons.manage_history_outlined,
      text: 'Progress',
      activeIcon: Icons.manage_history,
    ),
  ];
}
