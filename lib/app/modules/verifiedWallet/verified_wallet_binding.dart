import 'package:get/get.dart';

import 'verified_wallet_controller.dart';

class VerifiedWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifiedWalletController());
  }
}
