import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.color,
  }) : super(key: key);

  final void Function()? onPressed;
  final IconData? icon;
  final String? label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: Get.width,
        height: Get.height * 0.05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color == null ? Colors.white : color,
                ),
                SizedBox(width: Get.height * 0.01,),
                Text(
                  label!,
                  style: GoogleFonts.urbanist(fontSize: 16, color: color == null ? Colors.white : color),
                )
              ],
            ),
            Icon(
              LineIcons.angleRight,
              color: color == null ? Colors.white : color,
            )
          ],
        ),
      ),
    );
  }
}