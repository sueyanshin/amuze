import 'package:amuze_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const new({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.deepElectricBlue,
    this.color = Colors.white,
    required this.onPressed,
  });

  final Widget child;
  final Color backgroundColor;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: .all(14),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: .circular(12)),
      ),
      child: child,
    );
  }
}
