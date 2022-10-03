import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TrailerItem extends StatelessWidget {
  const TrailerItem({
    Key? key,
    required this.onPressed,
    required this.index,
  }) : super(key: key);

  final int? index;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: Get.width,
        height: Get.height * 0.14,
        margin: EdgeInsets.only(bottom: index != 9 ? Get.height * 0.02 : Get.height * 0.01, top: index == 0 ? Get.height * 0.02 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.width * 0.4,
              height: Get.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/image/poster.jpg"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: Icon(
                  Icons.play_circle_fill_outlined,
                  color: Colors.white,
                  size: Get.height * 0.050551470588235295,
                ),
              ),
            ),
            SizedBox(width: Get.height * 0.02,),
            Container(
              width: Get.width * 0.479,
              height: Get.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.height * 0.2377,
                        child: Text(
                          "Judul Film ${index}",
                          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                      Text(
                        "1m 45s",
                        style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF281920),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.height * 0.02),
                        child: Center(
                          child: Text(
                            "Update",
                            style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFFdf1221)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}