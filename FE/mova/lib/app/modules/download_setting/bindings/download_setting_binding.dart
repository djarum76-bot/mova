import 'package:get/get.dart';

import '../controllers/download_setting_controller.dart';

class DownloadSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DownloadSettingController>(
      () => DownloadSettingController(),
    );
  }
}
