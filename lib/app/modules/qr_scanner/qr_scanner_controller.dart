import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';

class QrScannerController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    getArgument();
    super.onReady();
  }

  String _address = '';
  String get address => _address;

  @override
  void onInit() {
    // TODO: implement onInit
    getArgument();
    super.onInit();
  }

  getCode(code) {
    if (code != null) {
      Get.offNamed(AppRoutes.SEND, arguments: [
        {
          "amount": Get.arguments[0]["amount"],
          "address": Get.arguments[0]["address"],
          "code": code
        }
      ]);
    }
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Share Address'.tr,
      text: _address,
      linkUrl: 'https://chimba.ooo/',
      chooserTitle: 'Share Address'.tr,
    );
  }

  Future<void> shareFile() async {
    var DocumentsPicker;
    List<dynamic> docs = await DocumentsPicker.pickDocuments;
    if (docs == null || docs.isEmpty) return null;

    await FlutterShare.shareFile(
      title: 'Shared addres',
      text: _address,
      filePath: docs[0] as String,
    );
  }

  getArgument() {
    print("Argumentos: ${Get.arguments}");
  }
}
