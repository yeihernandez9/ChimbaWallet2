import 'package:chimba_wallet/app/modules/navigator_bar/navigator_bar_controller.dart';
import 'package:get/get.dart';

class NavigatorBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigatorBarController());
  }
}
