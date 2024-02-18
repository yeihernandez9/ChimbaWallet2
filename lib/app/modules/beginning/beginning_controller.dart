import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';

class BeginningController extends GetxController {
  void wallet() {
    if (Get.arguments == 2) {
      Get.toNamed(AppRoutes.MNEMONIC, arguments: Get.arguments);
    } else {
      Get.toNamed(AppRoutes.MNEMONIC, arguments: 1);
    }
  }

  void importWallet() {
    if (Get.arguments == 2) {
      Get.toNamed(AppRoutes.IMPORT_MNEMONIC, arguments: Get.arguments);
    } else {
      Get.toNamed(AppRoutes.IMPORT_MNEMONIC, arguments: 1);
    }
  }
}
