import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.color,
    this.radius,
    this.side
  }) : super(key: key);

  final void Function()? onPressed;
  final Widget? child;
  final Color? color;
  final double? radius;
  final BorderSide? side;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        primary: color == null ? Color(0xFFE21221) : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius == null ? 20 : radius!),
          side: side == null ? BorderSide.none : side!
        ),
      ),
    );
  }
}