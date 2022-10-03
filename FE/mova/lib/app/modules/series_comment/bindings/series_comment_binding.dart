import 'package:get/get.dart';

import '../controllers/series_comment_controller.dart';

class SeriesCommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeriesCommentController>(
      () => SeriesCommentController(),
    );
  }
}
