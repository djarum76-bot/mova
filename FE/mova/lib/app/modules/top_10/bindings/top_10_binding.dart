import 'package:get/get.dart';

import '../controllers/top_10_controller.dart';

class Top10Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Top10Controller>(
      () => Top10Controller(),
    );
  }
}
