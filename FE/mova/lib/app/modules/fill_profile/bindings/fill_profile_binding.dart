import 'package:get/get.dart';

import '../controllers/fill_profile_controller.dart';

class FillProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FillProfileController>(
      () => FillProfileController(),
    );
  }
}
