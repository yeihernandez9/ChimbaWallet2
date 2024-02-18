import 'package:chimba_wallet/app/modules/walletCange/wallet_change_controller.dart';
import 'package:get/get.dart';

class WalletChangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletChangeController());
  }
}
