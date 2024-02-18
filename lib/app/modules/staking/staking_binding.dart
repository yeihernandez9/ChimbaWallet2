import 'package:chimba_wallet/app/modules/staking/staking_controller.dart';
import 'package:get/get.dart';

class StakingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StakingController());
  }
}
