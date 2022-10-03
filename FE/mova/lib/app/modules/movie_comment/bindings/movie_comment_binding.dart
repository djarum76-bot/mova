import 'package:get/get.dart';

import '../controllers/movie_comment_controller.dart';

class MovieCommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieCommentController>(
      () => MovieCommentController(),
    );
  }
}
