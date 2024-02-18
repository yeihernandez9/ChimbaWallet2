import 'package:chimba_wallet/app/modules/qr_scanner/qr_scanner_controller.dart';
import 'package:get/get.dart';

class QrScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QrScannerController());
  }
}