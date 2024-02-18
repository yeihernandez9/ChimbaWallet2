import 'package:chimba_wallet/app/core/utils/helpers/dataWalletHelper.dart';
import 'package:get/get.dart';

class ShowMnemonicController extends GetxController {
  List<String> _mnemonic = [];
  List<String> get mnemonic => _mnemonic;

  RxList userWalletItems = [].obs;

  String _textMnemonic = "";
  String get textMnemonic => _textMnemonic;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getMnemonic();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      getWallet();
    });
  }

  getMnemonic() async {
    DataWalletHelper.db
        .getUserWakketMapList()
        .then((walletList) => {userWalletItems.value = walletList});
  }

  getWallet() {
    String seed2 = Get.arguments;
    print("Mnemonic1; $seed2");
    String seed = Get.arguments;
    print("Mnemonic2; $seed");
    _mnemonic = seed.substring(1, seed.length - 1).split(', ');

    final String result = _mnemonic.join(' ');
    _textMnemonic = result;
    update();
  }
}
