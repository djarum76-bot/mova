import 'package:get/get.dart';

import '../controllers/new_release_controller.dart';

class NewReleaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewReleaseController>(
      () => NewReleaseController(),
    );
  }
}
