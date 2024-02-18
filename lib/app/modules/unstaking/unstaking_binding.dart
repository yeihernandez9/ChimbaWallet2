import 'package:chimba_wallet/app/modules/unstaking/unstaking_controller.dart';
import 'package:get/get.dart';

class UnstakingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UnstakingController());
  }
}
