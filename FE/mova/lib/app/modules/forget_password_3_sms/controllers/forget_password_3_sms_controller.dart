import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword3SmsController extends GetxController {
  late TextEditingController pin;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pin = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pin.dispose();
  }
}
