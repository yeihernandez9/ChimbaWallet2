import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';

class CreateWalletController extends GetxController {
  void newNemonic() {
    if(Get.arguments == 2){
      Get.toNamed(AppRoutes.MNEMONIC, arguments: Get.arguments);
    }else{
      Get.toNamed(AppRoutes.MNEMONIC, arguments: 1);
    }
    
  }
}
