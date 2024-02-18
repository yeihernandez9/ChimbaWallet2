// ignore_for_file: avoid_print

import 'package:chimba_wallet/app/core/utils/helpers/dataSettingHelper.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataWalletHelper.dart';
import 'package:chimba_wallet/app/data/model/request_get_wallets.dart';
import 'package:chimba_wallet/app/data/model/request_token_transaction.dart';
import 'package:chimba_wallet/app/data/model/request_transaction.dart';
import 'package:chimba_wallet/app/data/services/repository/wallet_repository.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';

class VerifiedWalletController extends GetxController {
  final WalletRepository _requestWallet = Get.put(WalletRepository());

  final List<dynamic> _getAllWallets = [];
  RxList userWalletItems = [].obs;
  RxList userSetting = [].obs;

  String walletId = '';

  String _address = '';
  String get address => _address;

  final RxString _addToken = ''.obs;
  RxString get addToken => _addToken;

  @override
  void onInit() async {
    await tokenTransaction();
    await fechtUserSetting();
    await getUserWalletItems();
    getWallet();
    getAllWallets();
    super.onInit();
  }

  getUserWalletItems() async {
    await DataWalletHelper.db
        .getUserWakketMapList()
        .then((walletList) => {userWalletItems.value = walletList});
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
        _address = element["address"];
      }
    });
  }

  goHome() {
    Get.offAllNamed(AppRoutes.WALLET_CHANGE, arguments: true);
  }

  tokenTransaction() async {
    RequestTokenTransaction requestTokenTransaction =
        await _requestWallet.getTokenTransaction();
    _addToken.value = requestTokenTransaction.token;
  }

  getAllWallets() async {
    RequestGetAllWallets requestGetAllWallets =
        await _requestWallet.getAllWallets();

    requestGetAllWallets.accounts
        .forEach((account) => {_getAllWallets.add(account)});

    print('aaaa${_getAllWallets.length}');
    await transactionMake();
  }

  transactionMake() async {
    if (_getAllWallets.length <= 5000) {
      RequestTransaction requestTransaction =
          await _requestWallet.makeTransaction(
              toAddress: _address, tokenTransaction: addToken.value);
      print('length${_getAllWallets.length}');
      print('Transaccion exitosa');
    } else {
      print('Limite de transacciones');
    }
  }
}
