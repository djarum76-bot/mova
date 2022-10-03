import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:mova/app/widget/download_item.dart';
import 'package:mova/app/widget/notification_item.dart';
import 'package:mova/app/widget/search_button.dart';

import '../controllers/download_controller.dart';

class DownloadView extends GetView<DownloadController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Container(
                width: Get.width,
                height: Get.height * 0.09,
                padding: EdgeInsets.all(Get.height * 0.02),
                child: Row(
                  children: [
                    Lottie.asset("asset/lottie/splash.json"),
                    SizedBox(width: Get.height * 0.01,),
                    AutoSizeText(
                      "Download",
                      style: GoogleFonts.urbanist(
                          fontSize: 22, fontWeight: FontWeight.w700),
                      maxLines: 1,
                    )
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.02,),
              Expanded(
                  child: controller.notEmpty.isEmpty
                      ? Container(
                          padding: EdgeInsets.all(Get.height * 0.02),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset("asset/lottie/empty.json"),
                              AutoSizeText(
                                "Your Download is Empty",
                                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFce1221)),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                              AutoSizeText(
                                "It seems that you haven't download any movies",
                                style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(horizontal: Get.height * 0.02),
                          child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index){
                                return DownloadItem(
                                    onPressed: (){
                                      Get.toNamed(Routes.VIDEO_PLAY);
                                    },
                                    index: index
                                );
                              }
                          ),
                        )
              )
            ],
          )
      ),
    );
  }
}