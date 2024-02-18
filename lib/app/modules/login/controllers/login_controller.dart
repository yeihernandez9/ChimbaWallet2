import 'package:chimba_wallet/app/core/utils/helpers/dataSettingHelper.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataWalletHelper.dart';
import 'package:chimba_wallet/app/data/services/auth/local_auth.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  RxList userWalletItems = [].obs;

  bool _showHide = true;
  bool get showHide => _showHide;

  bool _statusButton = false;
  bool get statusButton => _statusButton;

  RxString _password = ''.obs;
  RxString get password => _password;

  RxBool _errorPassword = true.obs;
  RxBool get errorPassword => _errorPassword;

  RxList userSetting = [].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    DataWalletHelper.db
        .getUserWakketMapList()
        .then((walletList) => {userWalletItems.value = walletList});
  }

  @override
  void onReady() {
    super.onReady();
    fechtUserSetting();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void onchangePassword(text) {
    _password.value = text;
  }

  fechtUserSetting() async {
    await DataSettingHelper.db
        .getSettingMapList()
        .then((settingList) => {
          userSetting.value = settingList
        });

    validationData();
  }

  Future<void> validationData() async {
    String statusAuth = (userSetting[0]["value_status"]);
    if (statusAuth == "true") {
      bool status = await LocalAuth.authenticate();
      if (status) {
        Get.offNamed(AppRoutes.NAVIGATORBAR);
      }
    }
  }

  void login() {
    if (_password.isEmpty) {
      _errorPassword.value = false;
    } else {
      if (_password.value == userWalletItems[0]["password"]) {
        _errorPassword.value = true;
        Get.offNamed(AppRoutes.NAVIGATORBAR);
      } else {
        _errorPassword.value = false;
      }
    }
  }

  showHidePassword() {
    print("esto esta cambiando por aqui");
  }
}
