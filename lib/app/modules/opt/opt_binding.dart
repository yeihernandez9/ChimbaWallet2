import 'package:chimba_wallet/app/modules/opt/opt_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class OptBindign extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OptController());
  }
}
