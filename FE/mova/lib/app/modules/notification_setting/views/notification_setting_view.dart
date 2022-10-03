import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/widget/notification_setting_item.dart';

import '../controllers/notification_setting_controller.dart';

class NotificationSettingView extends GetView<NotificationSettingController> {
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
                        "Notification",
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
                      NotificationSettingItem(label: "General Notification", status: controller.genNotif,),
                      NotificationSettingItem(label: "New Arrival", status: controller.newArriv,),
                      NotificationSettingItem(label: "New Services Available", status: controller.newServ,),
                      NotificationSettingItem(label: "New Releases Movie", status: controller.newRel,),
                      NotificationSettingItem(label: "App Updates", status: controller.appUp,),
                      NotificationSettingItem(label: "Subscription", status: controller.sub,),
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


