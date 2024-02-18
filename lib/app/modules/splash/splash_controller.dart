import 'package:chimba_wallet/app/core/utils/helpers/dataSettingHelper.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataWalletHelper.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashController extends GetxController {
  late VideoPlayerController _controller;
  VideoPlayerController get controller => _controller;
  RxList userWalletItems = [].obs;
  bool _authenticate = false;

  RxList userSetting = [].obs;

  @override
  void onInit() {
    super.onInit();
     initController();
    DataWalletHelper.db
        .getUserWakketMapList()
        .then((walletList) => {userWalletItems.value = walletList});

    fechtUserSetting();
    
  }

  int get count => userWalletItems.length;

  @override
  void onReady() {
    
    
    super.onReady();
    Future.delayed(const Duration(milliseconds: 1000), () {
      update();
    });
  }

  Future<void> validationData() async {
    if (count > 0) {
      Get.offNamed(AppRoutes.LOGIN);
    } else {
      Get.offNamed(AppRoutes.BEGINNING);
    }
  }

  fechtUserSetting() async {
    DataSettingHelper.db
        .getSettingMapList()
        .then((settingList) => {userSetting.value = settingList});
  }

   void initController() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
    // super.initState();

    _controller = VideoPlayerController.asset('assets/videos/splash.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.setLooping(true);
        _controller.play();
        // setState(() {});
        Future.delayed(const Duration(seconds: 8), () {
      validationData();
    });
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
