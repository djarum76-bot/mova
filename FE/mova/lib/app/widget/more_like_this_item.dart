import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreLikeThisItem extends StatelessWidget {
  const MoreLikeThisItem({
    Key? key,
    required this.onPressed,
    required this.index,
  }) : super(key: key);

  final void Function()? onPressed;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: Get.height * 0.5,
        width: Get.width * 0.4,
        margin: EdgeInsets.only(top: index! < 3 ? Get.height * 0.02 : 0, bottom: index! > 8 ? Get.height * 0.01 : 0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(index! % 2 == 0 ? "asset/image/poster.jpg" : "asset/image/series.jpg"),
                      fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
            Positioned(
              child: Container(
                width: Get.height * 0.04,
                height: Get.height * 0.03,
                decoration: BoxDecoration(
                    color: Color(0xFFe21221),
                    borderRadius: BorderRadius.circular(6)
                ),
                child: Center(
                  child: Text(
                    "8.9",
                    style: GoogleFonts.urbanist(fontSize: 12),
                  ),
                ),
              ),
              top: Get.height * 0.015,
              left: Get.height * 0.015,
            )
          ],
        ),
      ),
    );
  }
}