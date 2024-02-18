import 'package:chimba_wallet/app/modules/phone/phone_controller.dart';
import 'package:get/get.dart';

class PhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhoneController());
  }
}
