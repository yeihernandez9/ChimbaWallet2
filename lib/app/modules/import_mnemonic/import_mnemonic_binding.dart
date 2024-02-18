import 'package:chimba_wallet/app/modules/import_mnemonic/import_mnemonic_controller.dart';
import 'package:get/get.dart';

class ImportMnemonicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImportMnemonicController());
  }
}
