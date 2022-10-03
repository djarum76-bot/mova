import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayController extends GetxController {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializaPlayer(Get.arguments as String);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  Future<void> initializaPlayer(String url)async{
    videoPlayerController = VideoPlayerController.network(url);
    // videoPlayerController = VideoPlayerController.asset("asset/video/sample.mp4");

    await videoPlayerController.initialize();

    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Color(0xFFe71b2a),
          backgroundColor: Color(0xFF181a20),
          bufferedColor: Color(0xFF757575),
          handleColor: Color(0xFFffffff)
        ),
        placeholder: Container(color: Color(0xFF181a20),),
        autoInitialize: true
    );

    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.onClose();
  }
}
