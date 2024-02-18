import 'package:chimba_wallet/app/modules/beginning/beginning_controller.dart';
import 'package:get/get.dart';

class BeginningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BeginningController());
  }
}
