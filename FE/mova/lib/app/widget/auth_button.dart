import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final void Function()? onPressed;
  final IconData? icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.065,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.height * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                  icon
              ),
              AutoSizeText(
                label!,
                style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 16),
                maxLines: 1,
              )
            ],
          ),
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