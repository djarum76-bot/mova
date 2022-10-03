import 'package:get/get.dart';

import '../controllers/forget_password_2_sms_controller.dart';

class ForgetPassword2SmsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPassword2SmsController>(
      () => ForgetPassword2SmsController(),
    );
  }
}
