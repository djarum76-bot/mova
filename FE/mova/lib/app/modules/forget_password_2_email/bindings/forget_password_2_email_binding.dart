import 'package:get/get.dart';

import '../controllers/forget_password_2_email_controller.dart';

class ForgetPassword2EmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPassword2EmailController>(
      () => ForgetPassword2EmailController(),
    );
  }
}
