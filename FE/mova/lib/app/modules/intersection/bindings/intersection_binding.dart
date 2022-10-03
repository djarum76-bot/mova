import 'package:get/get.dart';

import '../controllers/intersection_controller.dart';

class IntersectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntersectionController>(
      () => IntersectionController(),
    );
  }
}
