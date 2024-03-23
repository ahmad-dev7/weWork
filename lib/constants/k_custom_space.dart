import 'package:flutter/material.dart';

class KVerticalSpace extends StatelessWidget {
  final double? height;

  const KVerticalSpace({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height ?? 20);
  }
}

class KHorizontalSpace extends StatelessWidget {
  final double? width;
  const KHorizontalSpace({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width ?? 10);
  }
}

class KHorizontalPadding extends StatelessWidget {
  final Widget child;
  const KHorizontalPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: child,
    );
  }
}
