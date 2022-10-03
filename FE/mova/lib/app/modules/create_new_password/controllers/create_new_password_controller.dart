import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPasswordController extends GetxController {
  late TextEditingController pass;
  late TextEditingController conf_pass;

  final remember = false.obs;

  final pass_sec = true.obs;
  final conf_pass_sec = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pass = TextEditingController();
    conf_pass = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pass.dispose();
    conf_pass.dispose();
  }
}
