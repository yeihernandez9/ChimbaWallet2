import 'package:chimba_wallet/app/modules/nfts/nfts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';


class NftsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NftsController>(
        builder: (_) => Scaffold(
              extendBodyBehindAppBar: false,
              backgroundColor: Colors.black,
              body: Center(
                child: _.controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _.controller.value.aspectRatio,
                        child: VideoPlayer(_.controller),
                      )
                    : const Text(
                        'Proximamente...', 
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ));
  }
}
