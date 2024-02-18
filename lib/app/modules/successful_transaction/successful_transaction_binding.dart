
import 'package:chimba_wallet/app/modules/successful_transaction/successful_transaction_controller.dart';
import 'package:get/get.dart';

class SuccessfulTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuccessfulTransactionController());
  }
}