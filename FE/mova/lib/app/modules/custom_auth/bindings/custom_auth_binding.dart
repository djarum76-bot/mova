import 'package:get/get.dart';

import '../controllers/custom_auth_controller.dart';

class CustomAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomAuthController>(
      () => CustomAuthController(),
    );
  }
}
