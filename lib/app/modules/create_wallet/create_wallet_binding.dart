import 'package:chimba_wallet/app/modules/create_wallet/create_wallet_controller.dart';
import 'package:get/get.dart';

class CreateWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateWalletController());
  }
}
