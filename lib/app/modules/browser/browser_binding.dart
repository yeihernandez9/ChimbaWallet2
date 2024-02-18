import 'package:chimba_wallet/app/modules/browser/browser_controller.dart';
import 'package:get/get.dart';

class BrowserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BrowserController());
  }
}
