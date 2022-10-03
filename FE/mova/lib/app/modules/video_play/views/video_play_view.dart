import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/video_play_controller.dart';

class VideoPlayView extends GetView<VideoPlayController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              GetBuilder<VideoPlayController>(
                  init: VideoPlayController(),
                  builder: (control){
                    return Expanded(
                        child: Center(
                            child: control.chewieController != null && control.chewieController!.videoPlayerController.value.isInitialized
                                ? Chewie(controller: control.chewieController!)
                                : CircularProgressIndicator()
                        )
                    );
                  }
              )
            ],
          )
      ),
    );
  }
}
