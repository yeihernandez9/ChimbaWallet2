import 'package:chimba_wallet/app/modules/import_wallet/import_wallet_controller.dart';
import 'package:get/get.dart';

class ImportWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImportWalletController());
  }
}
