import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mova/app/modules/notification_setting/controllers/notification_setting_controller.dart';

class NotificationSettingItem extends GetView<NotificationSettingController> {
  const NotificationSettingItem({
    Key? key,
    required this.label,
    required this.status
  }) : super(key: key);

  final String? label;
  final Rx<bool> status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label!,
            style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Obx(() {
            return FlutterSwitch(
              activeColor: Color(0xFFe21221),
              inactiveColor: Color(0xFF35383f),
              borderRadius: 30.0,
              height: Get.height * 0.0325,
              width: Get.height * 0.065,
              value: status.value,
              onToggle: (val) {
                status.value = val;
              },
            );
          })
        ],
      ),
    );
  }
}