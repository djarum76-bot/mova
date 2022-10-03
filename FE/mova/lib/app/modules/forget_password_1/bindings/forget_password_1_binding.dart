import 'package:get/get.dart';

import '../controllers/forget_password_1_controller.dart';

class ForgetPassword1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPassword1Controller>(
      () => ForgetPassword1Controller(),
    );
  }
}
