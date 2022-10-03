import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareSocialButton extends StatelessWidget {
  const ShareSocialButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  final void Function()? onPressed;
  final IconData? icon;
  final String? label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: Get.height * 0.1,
        height: Get.height * 0.116,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: Get.height * 0.040551470588235295,
              backgroundColor: color,
              child: Icon(icon, size: Get.height * 0.060551470588235295, color: Colors.white,),
            ),
            Text(
              label!,
              style: GoogleFonts.urbanist(),
            )
          ],
        ),
      ),
    );
  }
}