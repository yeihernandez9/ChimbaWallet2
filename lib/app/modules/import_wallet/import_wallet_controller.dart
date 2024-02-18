import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';

class ImportWalletController extends GetxController {
  void importMmemonic() {
    if (Get.arguments == 2) {
      Get.toNamed(AppRoutes.IMPORT_MNEMONIC, arguments: Get.arguments);
    } else {
      Get.toNamed(AppRoutes.IMPORT_MNEMONIC, arguments: 1);
    }
  }
}
