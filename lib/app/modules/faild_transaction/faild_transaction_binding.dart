import 'package:chimba_wallet/app/modules/faild_transaction/faild_transaction_controller.dart';
import 'package:get/get.dart';

class FaildTransacctionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FaildTransacctionController());
  }
}
