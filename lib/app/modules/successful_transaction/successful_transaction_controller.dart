import 'package:chimba_wallet/app/core/utils/constant/constant.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SuccessfulTransactionController extends GetxController {
  RxString _hash = ''.obs;
  RxString get hash => _hash;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getHash();
  }

  gohome() {
    Get.offNamed(AppRoutes.NAVIGATORBAR);
  }

  getHash() {
    _hash.value = Get.arguments;
  }

  goUrl(String text) async {
    final Uri _url = Uri.parse('${Constants.EXPLORER}$text');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
