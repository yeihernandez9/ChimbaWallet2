// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:chimba_wallet/app/core/utils/helpers/dataSettingHelper.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataWalletHelper.dart';
import 'package:chimba_wallet/app/data/model/setting.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  var nameWalletHome = Get.arguments;

  RxList userWalletItems = [].obs;

  RxList userSetting = [].obs;

  final RxString _nameWallet = ''.obs;
  RxString get nameWallet => _nameWallet;

  String walletId = '';

  @override
  void onInit() {
    fechWallet();
    update();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await fechtUserSetting();
    await getWallet();
    // TODO: implement onReady
    update();
    super.onReady();
  }

  fechWallet() async {
    DataWalletHelper.db
        .getUserWakketMapList()
        .then((walletList) => {userWalletItems.value = walletList});
    print('walletIdAccount$walletId');
    update();
  }

  fechtUserSetting() async {
    await DataSettingHelper.db
        .getSettingMapList()
        .then((settingList) => {userSetting.value = settingList});
    walletId = (userSetting[1]["value_status"]);
  }

  getWallet() {
    userWalletItems.forEach((element) {
      if (element["id"] == int.parse(walletId)) {
        _nameWallet.value = element["wallet"];
      }
    });
    print('_nameWallet${_nameWallet.value}');
  }

  goCreateWallet() {
    Get.toNamed(AppRoutes.BEGINNING, arguments: 2);
  }

  changeWallet(int id) {
    Setting dataSetting = Setting(
      id: 2,
      name: 'Wallet',
      value_status: id.toString(),
      description: "Select Wallet",
    );

    try {
      DataSettingHelper.db.updateSetting(dataSetting).then((value) {
        updateSetting(dataSetting);
      });
    } catch (e) {
      print(e);
    }
  }

  void updateSetting(Setting setting) async {
    await Get.offAllNamed(AppRoutes.WALLET_CHANGE, arguments: 0);
  }
}
