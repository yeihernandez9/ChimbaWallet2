import 'package:chimba_wallet/app/modules/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        builder: (_) => Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
                child: _.controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _.controller.value.aspectRatio,
                        child: VideoPlayer(_.controller),
                      )
                    : Container(),
              ),
            ));
  }
}
