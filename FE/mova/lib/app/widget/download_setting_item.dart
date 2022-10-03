import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadSettingItem extends StatelessWidget {
  const DownloadSettingItem({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  final void Function()? onPressed;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: Get.width,
        height: Get.height * 0.05,
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: Color(0xFFf4313f),
            ),
            SizedBox(width: Get.height * 0.01,),
            Text(
              label!,
              style: GoogleFonts.urbanist(fontSize: 16, color: Color(0xFFf4313f), fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}