import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class SubscribeItem extends StatelessWidget {
  const SubscribeItem({
    Key? key,
    required this.onPressed,
    required this.price,
    required this.time,
  }) : super(key: key);

  final void Function()? onPressed;
  final String? price;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Color(0xFFea202f), width: 3),
            color: Color(0xFF1f222a)
        ),
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.02, horizontal: Get.height * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Icon(
                LineIcons.crown,
                color: Color(0xFFf12c3a),
                size: 60,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  price!,
                  style: GoogleFonts.urbanist(fontSize: 30, fontWeight: FontWeight.w700),
                  maxLines: 1,
                ),
                AutoSizeText(
                  time!,
                  style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFFe0e0e0)),
                  maxLines: 1,
                )
              ],
            ),
            Divider(color: Color(0xFF35383f), thickness: 2,),
            Row(
              children: [
                Icon(
                  LineIcons.check,
                  color: Color(0xFFf12c3a),
                ),
                SizedBox(width: Get.height * 0.01,),
                AutoSizeText(
                  "Watch all you want. Ad Free.",
                  style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFe0e0e0)),
                  maxLines: 1,
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  LineIcons.check,
                  color: Color(0xFFf12c3a),
                ),
                SizedBox(width: Get.height * 0.01,),
                AutoSizeText(
                  "Allows streaming of 4K",
                  style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFe0e0e0)),
                  maxLines: 1,
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  LineIcons.check,
                  color: Color(0xFFf12c3a),
                ),
                SizedBox(width: Get.height * 0.01,),
                AutoSizeText(
                  "Video & Audio Quality is Better",
                  style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFe0e0e0)),
                  maxLines: 1,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}