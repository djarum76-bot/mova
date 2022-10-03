import 'package:get/get.dart';

import '../controllers/forget_password_3_sms_controller.dart';

class ForgetPassword3SmsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPassword3SmsController>(
      () => ForgetPassword3SmsController(),
    );
  }
}
