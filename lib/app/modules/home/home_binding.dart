import 'package:chimba_wallet/app/modules/home/home_controller.dart';
import 'package:chimba_wallet/app/modules/setting/setting_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SettingController());
  }
}