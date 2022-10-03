import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword2EmailController extends GetxController {
  late TextEditingController email;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    email = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
  }
}
