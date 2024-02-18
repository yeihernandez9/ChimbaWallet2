import 'package:chimba_wallet/app/core/utils/helpers/dataWalletHelper.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:sacco/sacco.dart';

class MnemonicController extends GetxController {
  List<String> _mnemonic = [];
  List<String> get mnemonic => _mnemonic;
  String _textMnemonic = "";
  String get textMnemonic => _textMnemonic;

  RxBool _errorWallet = false.obs;
  RxBool get errorWallet => _errorWallet;

  RxBool _errorPassword = false.obs;
  RxBool get errorPassword => _errorPassword;

  RxBool _errorPasswordConfirm = false.obs;
  RxBool get errorPasswordConfirm => _errorPasswordConfirm;

  String _nameWallet = '';
  String get nameWallet => _nameWallet;

  RxString _password = ''.obs;
  RxString get password => _password;

  RxString _confirmPassword = ''.obs;
  RxString get confirmPassword => _confirmPassword;

  int _indexCustomer = 0;
  int get indexCustomer => _indexCustomer;

  int _status = 0;
  int get status => _status;

  RxList userWallets = [].obs;

  @override
  void onReady() {
    // TODO: implement onReady
    _status = Get.arguments;
    fechtUserWallet();
    initNemonic();
    mnemonicText();
    update();
    super.onReady();
  }

  fechtUserWallet() async {
    DataWalletHelper.db
        .getUserWakketMapList()
        .then((userWalletList) => {userWallets.value = userWalletList});

    update();
  }

  Future<void> initNemonic() async {
    _mnemonic = Bip39.generateMnemonic(strength: 128).split(' ');
    update();
  }

  Future<void> mnemonicText() async {
    final String result = _mnemonic.join(' ');
    _textMnemonic = result;
    update();
  }

  Future<void> verifyMnemonic() async {
    if (userWallets.isNotEmpty) {
      if (_nameWallet.isEmpty) {
        _errorWallet.value = true;
      } else {
        _errorWallet.value = false;
      }

      if (!_errorWallet.value) {
        Get.toNamed(AppRoutes.VERIFYMNEMONIC, arguments: {
          "walleData": {
            "mnemonic": mnemonic,
            "nameWallet": _nameWallet,
            "password": userWallets[0]["password"]
          },
          "walletStatus": 1
        });
      }
    } else {
      if (_nameWallet.isEmpty) {
        _errorWallet.value = true;
      } else {
        _errorWallet.value = false;
      }

      if (_password.isEmpty) {
        _errorPassword.value = true;
      } else {
        _errorPassword.value = false;
      }

      if (_confirmPassword.isEmpty) {
        _errorPasswordConfirm.value = true;
      } else {
        _errorPasswordConfirm.value = false;
      }

      if (!_errorWallet.value &&
          !_errorPassword.value &&
          !_errorPasswordConfirm.value) {
        if (_password != _confirmPassword) {
        } else {
          Get.toNamed(AppRoutes.VERIFYMNEMONIC, arguments: {
            "walleData": {
              "mnemonic": mnemonic,
              "nameWallet": _nameWallet,
              "password": _password
            },
            "walletStatus": 2
          });
        }
      }
    }
  }

  void onChangeWallet(String text) {
    _nameWallet = text;
    if (_nameWallet.isEmpty) {
      _errorWallet.value = true;
    } else {
      _errorWallet.value = false;
    }
  }

  void onChangePassword(String text) {
    _password.value = text;
    if (_password.isEmpty) {
      _errorPassword.value = true;
    } else {
      _errorPassword.value = false;
    }
  }

  void onChangePasswordConfirm(String text) {
    _confirmPassword.value = text;
    if (_confirmPassword.isEmpty) {
      _errorPasswordConfirm.value = true;
    } else {
      _errorPasswordConfirm.value = false;
    }
  }
}
