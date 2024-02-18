import 'package:chimba_wallet/app/modules/mnemonic/mnemonic_controller.dart';
import 'package:get/get.dart';

class MnemonicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MnemonicController());
  }
}
