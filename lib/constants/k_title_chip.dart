import 'package:flutter/material.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_my_text.dart';

class KTitleChip extends StatelessWidget {
  final String label;
  final IconData iconData;
  const KTitleChip({super.key, required this.label, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: backgroundColor,
      label: KMyText(label, weight: FontWeight.bold),
      deleteIcon: Icon(iconData, color: accentColor),
      deleteButtonTooltipMessage: '',
      onDeleted: () {},
    );
  }
}
