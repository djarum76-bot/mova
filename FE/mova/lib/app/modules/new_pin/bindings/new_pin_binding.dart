import 'package:get/get.dart';

import '../controllers/new_pin_controller.dart';

class NewPinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPinController>(
      () => NewPinController(),
    );
  }
}
