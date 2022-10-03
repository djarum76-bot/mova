import 'package:get/get.dart';
import 'package:mova/app/modules/download/controllers/download_controller.dart';
import 'package:mova/app/modules/explore/controllers/explore_controller.dart';
import 'package:mova/app/modules/home/controllers/home_controller.dart';
import 'package:mova/app/modules/my_list/controllers/my_list_controller.dart';
import 'package:mova/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/navbar_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<ExploreController>(
          () => ExploreController(),
    );
    Get.lazyPut<MyListController>(
          () => MyListController(),
    );
    Get.lazyPut<DownloadController>(
          () => DownloadController(),
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
  }
}
