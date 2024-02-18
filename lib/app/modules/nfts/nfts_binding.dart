import 'package:chimba_wallet/app/modules/nfts/nfts_controller.dart';
import 'package:get/get.dart';

class NftsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NftsController());
  }
}