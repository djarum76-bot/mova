import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:mova/app/widget/download_setting_item.dart';
import 'package:mova/app/widget/notification_setting_item.dart';

import '../controllers/download_setting_controller.dart';

class DownloadSettingView extends GetView<DownloadSettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(Get.height * 0.02),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * 0.04,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        borderRadius: BorderRadius.circular(100),
                        child: Icon(
                          LineIcons.arrowLeft,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: Get.height * 0.02,),
                      AutoSizeText(
                        "Download",
                        style: GoogleFonts.urbanist(
                            fontSize: 22, fontWeight: FontWeight.w700),
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.04,),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        width: Get.width,
                        height: Get.height * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  LineIcons.wifi,
                                  color: Colors.white,
                                ),
                                SizedBox(width: Get.height * 0.01,),
                                Text(
                                  "Wi-Fi Only",
                                  style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Obx(() {
                              return FlutterSwitch(
                                activeColor: Color(0xFFe21221),
                                inactiveColor: Color(0xFF35383f),
                                borderRadius: 30.0,
                                height: Get.height * 0.0325,
                                width: Get.height * 0.065,
                                value: controller.wifi.value,
                                onToggle: (val) {
                                  controller.wifi.value = val;
                                },
                              );
                            })
                          ],
                        ),
                      ),
                      DownloadSettingItem(
                          onPressed: (){
                            Get.bottomSheet(
                              Container(
                                padding: EdgeInsets.all(Get.height * 0.02),
                                height: Get.height * 0.24,
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
                                            height: Get.height * 0.01,
                                          ),
                                          Divider(
                                            color: Color(0xFF30333b),
                                            thickness: 2,
                                          ),
                                          AutoSizeText(
                                            "Are you sure you want to delete all download ?",
                                            style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20),
                                            textAlign: TextAlign.center,
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
                          label: "Delete All Downloads"
                      ),
                      DownloadSettingItem(
                          onPressed: (){
                            Get.bottomSheet(
                              Container(
                                padding: EdgeInsets.all(Get.height * 0.02),
                                height: Get.height * 0.24,
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
                                            height: Get.height * 0.01,
                                          ),
                                          Divider(
                                            color: Color(0xFF30333b),
                                            thickness: 2,
                                          ),
                                          AutoSizeText(
                                            "Are you sure you want to delete all cache ?",
                                            style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20),
                                            textAlign: TextAlign.center,
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
                          label: "Delete Cache"
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
