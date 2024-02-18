import 'package:chimba_wallet/app/modules/verify_mnemonic/verify_mnemonic_controller.dart';
import 'package:get/get.dart';

class VerifyMnemonicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyMnemonicController());
  }
}
