import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class BrowserController extends GetxController {
  late VideoPlayerController _controller;
  VideoPlayerController get controller => _controller;

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 1000), () {
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    initController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    stop();
    _controller.dispose();
    super.onClose();
  }

  void initController() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
    // super.initState();

    _controller = VideoPlayerController.asset('assets/videos/credit_card.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.setLooping(true);
        _controller.play();
        // setState(() {});
      });
  }

  stop() {
    _controller.pause();
    _controller.seekTo(Duration.zero);
  }

  void pauseVideo() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    }
  }
}
