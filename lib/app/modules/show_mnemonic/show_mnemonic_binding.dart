import 'package:chimba_wallet/app/modules/show_mnemonic/show_mnemonic_controller.dart';
import 'package:get/get.dart';

class ShowMnemonicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShowMnemonicController());
  }
}
