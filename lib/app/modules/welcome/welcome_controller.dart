import 'package:chimba_wallet/app/core/utils/constant/constant.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataSettingHelper.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataWalletHelper.dart';
import 'package:chimba_wallet/app/data/model/setting.dart';
import 'package:chimba_wallet/app/data/model/user_wallet.dart';
import 'package:chimba_wallet/app/data/services/auth/local_auth.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:sacco/sacco.dart';

class WelcomeController extends GetxController {
  RxList userWallets = [].obs;
  RxList userSetting = [].obs;

  RxBool _enableBtn = true.obs;
  RxBool get enableBtn => _enableBtn;

  RxBool on = false.obs;

  @override
  void onInit() {
    userWallets.value = [];
    print('arguments ${Get.arguments}');
    // TODO: implement onInit
    fechtUserWallet();
    fechtUserSetting();
    checkSettingAuth('Biometric');
    checkSettingAuth('Wallet');
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    createWallet();
    super.onReady();
  }

  Future<void> createWallet() async {
    final networkInfo = NetworkInfo(
      bech32Hrp: Constants.CHAIN,
      lcdUrl: Uri.parse(Constants.API_CHIMBA),
    );

    final wallet =
        Wallet.derive(Get.arguments["walleData"]["mnemonic"], networkInfo);
    final address = wallet.bech32Address;

    var datawallet = UserWallet(
      wallet: Get.arguments["walleData"]["nameWallet"].toString(),
      password: Get.arguments["walleData"]["password"].toString(),
      address: address,
      mnemonic: Get.arguments["walleData"]["mnemonic"].toString(),
    );
    addUserWallet(datawallet);
  }

  fechtUserWallet() async {
    DataWalletHelper.db
        .getUserWakketMapList()
        .then((userWalletList) => {userWallets.value = userWalletList});

    update();
  }

  Future<void> addUserWallet(UserWallet userWallet) async {
    try {
      if (userWallet.id != null) {
        DataWalletHelper.db.updateUserWallet(userWallet).then((value) {
          updateUserWallet(userWallet);
        });
      } else {
        DataWalletHelper.db
            .insertUserWallet(userWallet);
      }
    } catch (e) {
      print(e);
    }
  }

  void updateList(UserWallet userWallet) async {
    var result = await fechtUserWallet();
    if (result != null) {
      final index = userWallets.indexOf(userWallet);
      userWallets[index] = userWallet;
    }
  }

  void updateUserWallet(UserWallet userWallet) {
    DataWalletHelper.db
        .updateUserWallet(userWallet)
        .then((value) => updateList(userWallet));
  }

  void getHome() {
    Get.offAllNamed(AppRoutes.NAVIGATORBAR, arguments: 0);
  }

  void toggle() async {
    on.value = on.value ? false : true;
    bool status = await LocalAuth.authenticate();

    if (!status && on.value) {
      on.value = status;
      updateSettingAuth(status);
    } else {
      if (status && on.value) {
        updateSettingAuth(status);
        Get.offAllNamed(AppRoutes.NAVIGATORBAR, arguments: 0);
      } else {
        if (!status && !on.value) {
          status = true;
          on.value = true;
          updateSettingAuth(status);
        } else {
          status = false;
          updateSettingAuth(status);
        }
      }
    }
  }

  fechtUserSetting() async {
    DataSettingHelper.db
        .getSettingMapList()
        .then((settingList) => {userSetting.value = settingList});
  }

  updateSettingWallet() {
    try {
      DataWalletHelper.db.getUserWakketMapList().then((value) {
        Setting setting = Setting(
            id: 2,
            name: "wallet",
            value_status: value[0]["id"].toString(),
            description: "Select Wallet");

        updateSetting(setting);
      });
    } catch (e) {
      print(e);
    }
  }

  checkSettingAuth(String name) async {
    try {
      var listRowsSetting = await DataSettingHelper.db.getSettingMapList();

      int i = 0;
      while (i < listRowsSetting.length &&
          listRowsSetting[i]['name'].toString() != name) {
        i++;
      }

      if (i >= listRowsSetting.length) {
        if (name == "Wallet") {
          createSettingWallet(1);
        } else {
          createSettingAuth(false);
        }
      } else {
        updateSettingWallet();
      }
    } catch (e) {
      print(e);
    }
  }

  createSettingAuth(bool status) async {
    if (Get.arguments["walletStatus"] == 2) {
      Setting dataSetting = Setting(
        name: 'Biometric',
        value_status: false.toString(),
        description: "Authentication with Biometric",
      );

      try {
        DataSettingHelper.db
            .insertSetting(dataSetting)
            .then((value) => userWallets.add(dataSetting));
      } catch (e) {
        print(e);
      }
    }
  }

  void updateSettingAuth(status) {
    Setting dataSetting = Setting(
      id: 1,
      name: 'Biometric',
      value_status: status.toString(),
      description: "Authentication with Biometric",
    );

    try {
      DataSettingHelper.db.updateSetting(dataSetting).then((value) {
        updateSetting(dataSetting);
      });
    } catch (e) {
      print(e);
    }
  }

  void updateSetting(Setting setting) {
    DataSettingHelper.db
        .updateSetting(setting)
        .then((value) => updateListSetting(setting));
  }

  void updateListSetting(Setting setting) async {
    var result = await fechtUserSetting();
    if (result != null) {
      final index = userSetting.indexOf(setting);
      userSetting[index] = setting;
    }
  }

  createSettingWallet(int idWallet) {
    if (Get.arguments["walletStatus"] == 2) {
      Setting dataSetting = Setting(
        name: 'Wallet',
        value_status: idWallet.toString(),
        description: "Select Wallet",
      );

      try {
        DataSettingHelper.db
            .insertSetting(dataSetting)
            .then((value) => userWallets.add(dataSetting));
      } catch (e) {
        print(e);
      }
    }
  }
}
