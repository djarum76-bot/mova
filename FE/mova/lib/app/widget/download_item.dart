import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mova/app/widget/app_button.dart';

class DownloadItem extends StatelessWidget {
  const DownloadItem({
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
        width: Get.width,
        height: Get.height * 0.14,
        margin: EdgeInsets.only(bottom: index != 9 ? Get.height * 0.02 : 0),
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
                    image: AssetImage(index! % 2 == 0 ? "asset/image/poster.jpg" : "asset/image/series.jpg"),
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
                        "1h 32m 5s",
                        style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF281920),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.height * 0.02),
                            child: Center(
                              child: Text(
                                "1.5 GB",
                                style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFFdf1221)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            ),
                          ),
                          SizedBox(width: Get.height * 0.12,),
                          InkWell(
                            onTap: (){
                              Get.bottomSheet(
                                Container(
                                  padding: EdgeInsets.all(Get.height * 0.02),
                                  height: Get.height * 0.45,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF1f222a),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      )
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: AutoSizeText(
                                                "Delete",
                                                style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20, color: Color(0xFFef5252)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.02,
                                            ),
                                            Divider(
                                              color: Color(0xFF30333b),
                                              thickness: 2,
                                            ),
                                            AutoSizeText(
                                              "Are you sure you want to delete this movie download ?",
                                              style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.02,
                                            ),
                                            Container(
                                              width: Get.width,
                                              height: Get.height * 0.14,
                                              margin: EdgeInsets.only(bottom: index != 9 ? Get.height * 0.02 : 0),
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
                                                          image: AssetImage(index! % 2 == 0 ? "asset/image/poster.jpg" : "asset/image/series.jpg"),
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
                                                              "1h 32m 5s",
                                                              style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 16),
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
                                                                  "1.5 GB",
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
                                            Divider(
                                              color: Color(0xFF30333b),
                                              thickness: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Get.width,
                                        height: Get.height * 0.06,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  height: Get.height * 0.06,
                                                  child: AppButton(
                                                      color: Color(0xFF35383f),
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: AutoSizeText(
                                                        "Cancel",
                                                        style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
                                                        maxLines: 1,
                                                      )
                                                  ),
                                                )
                                            ),
                                            SizedBox(
                                              width: Get.height * 0.02,
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  height: Get.height * 0.06,
                                                  child: AppButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: AutoSizeText(
                                                        "Yes, Delete",
                                                        style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
                                                        maxLines: 1,
                                                      )
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(200),
                            child: Container(
                              width: Get.height * 0.03,
                              height: Get.height * 0.03,
                              child: Icon(
                                Icons.delete,
                                color: Color(0xFFdf1221),
                              ),
                            ),
                          )
                        ],
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