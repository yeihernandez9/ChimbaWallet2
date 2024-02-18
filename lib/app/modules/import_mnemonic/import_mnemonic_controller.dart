import 'package:chimba_wallet/app/core/utils/constant/constant.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataWalletHelper.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacco/network_info.dart';
import 'package:sacco/wallet.dart';

class ImportMnemonicController extends GetxController {
  TextEditingController pageEditingController = TextEditingController();

  RxString _textCopy = "".obs;
  RxString get textCopy => _textCopy;

  RxBool _errorMnemonicConfirm = false.obs;
  RxBool get errorMnemonicConfirm => _errorMnemonicConfirm;

  RxBool _errorMnemonics = false.obs;
  RxBool get errorMnemonics => _errorMnemonics;

  RxBool _errorWallet = false.obs;
  RxBool get errorWallet => _errorWallet;

  RxBool _errorPassword = false.obs;
  RxBool get errorPassword => _errorPassword;

  RxBool _errorPasswordConfirm = false.obs;
  RxBool get errorPasswordConfirm => _errorPasswordConfirm;

  String _mnemonic = '';
  String get mnemonic => _mnemonic;

  String _nameWallet = '';
  String get nameWallet => _nameWallet;

  RxString _password = ''.obs;
  RxString get password => _password;

  RxString _confirmPassword = ''.obs;
  RxString get confirmPassword => _confirmPassword;

  int _status = 0;
  int get status => _status;

  RxList userWallets = [].obs;

  final networkInfo = NetworkInfo(
    bech32Hrp: Constants.CHAIN,
    lcdUrl: Uri.parse(Constants.API_CHIMBA),
  );

  @override
  void onReady() {
    // TODO: implement onReady
    _status = Get.arguments;
    fechtUserWallet();
    update();
    super.onReady();
  }

  fechtUserWallet() async {
    DataWalletHelper.db
        .getUserWakketMapList()
        .then((userWalletList) => {userWallets.value = userWalletList});

    update();
  }

  copyText(String text) {
    _textCopy.value = text;

    pageEditingController.text = text;
  }

  void onChangeMnemonic(String text) {
    _mnemonic = text;
    if (_mnemonic.isEmpty) {
      _errorMnemonicConfirm.value = true;
    } else {
      _errorMnemonicConfirm.value = false;
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

  Future<void> verifyMnemonic() async {
    if (userWallets.isNotEmpty) {
      if (_mnemonic.isEmpty) {
        _errorMnemonicConfirm.value = true;
      } else {
        _errorMnemonicConfirm.value = false;
      }

      _mnemonic = pageEditingController.text;

      List<String> tal = _mnemonic.split(' ');

      if (!_errorWallet.value) {
        Get.toNamed(AppRoutes.WELCOME, arguments: {
          "walleData": {
            "mnemonic": tal,
            "nameWallet": _nameWallet,
            "password": userWallets[0]["password"]
          },
          "walletStatus": 1
        });
      }
    } else {
      if (_mnemonic.isEmpty) {
        _errorMnemonicConfirm.value = true;
      } else {
        _errorMnemonicConfirm.value = false;
      }

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

      _mnemonic = pageEditingController.text;

      List<String> tal = _mnemonic.split(' ');

      if (!_errorWallet.value &&
          !_errorPassword.value &&
          !_errorPasswordConfirm.value) {
        if (_password == _confirmPassword) {
          try {
            final wallet = Wallet.derive(tal, networkInfo);

            Get.toNamed(
              AppRoutes.WELCOME,
              arguments: {
                "walleData": {
                  "mnemonic": tal,
                  "nameWallet": _nameWallet,
                  "password": _password
                },
                "walletStatus": 2
              },
            );
          } catch (e) {
            _errorMnemonics.value = true;
            print(_errorMnemonics.value);
            update();
          }
        }
      }
    }
  }
}
