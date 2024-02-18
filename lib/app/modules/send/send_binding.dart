import 'package:chimba_wallet/app/modules/send/send_controller.dart';
import 'package:get/get.dart';

class SendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SendController());
  }
}
