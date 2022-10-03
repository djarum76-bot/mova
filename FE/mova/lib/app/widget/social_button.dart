import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.height * 0.1,
      height: Get.height * 0.08,
      margin: EdgeInsets.symmetric(horizontal: Get.height * 0.01),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Center(
          child: Icon(icon),
        ),
        style: ElevatedButton.styleFrom(
          side: BorderSide(
              color: Color(0xFF32353c),
              width: 1
          ),
          primary: Color(0xFF1f222a),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}