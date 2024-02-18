import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';

class WalletChangeController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 1), () {
      goNavigatorBar();
    });
    super.onInit();
  }

  goNavigatorBar() {
    Get.offAllNamed(AppRoutes.NAVIGATORBAR, arguments: 0);
  }
}
