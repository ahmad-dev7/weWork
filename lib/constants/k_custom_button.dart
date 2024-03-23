
import 'package:flutter/material.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_values.dart';

class KCustomButton extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  final Color? color;
  const KCustomButton(
      {super.key, required this.child, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: cardColor,
      onPressed: onTap,
      height: 50,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      color: color ?? accentColor,
      minWidth: double.maxFinite,
      child: child,
    );
  }
}
