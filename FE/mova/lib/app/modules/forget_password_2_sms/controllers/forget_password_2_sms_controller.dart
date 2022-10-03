import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword2SmsController extends GetxController {
  late TextEditingController phone;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    phone = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phone.dispose();
  }
}
