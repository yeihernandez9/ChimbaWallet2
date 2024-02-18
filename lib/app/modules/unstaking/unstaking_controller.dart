import 'package:alan/proto/cosmos/staking/v1beta1/export.dart';
import 'package:chimba_wallet/app/core/utils/constant/constant.dart';
import 'package:chimba_wallet/app/global_widgets/loading_dialog.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:alan/alan.dart';

import '../../core/utils/helpers/dataWalletHelper.dart';

class UnstakingController extends GetxController {
  final isLoading = false.obs;

  RxList userWalletItems = [].obs;

  List<String> _mnemonic = [];
  List<String> get mnemonic => _mnemonic;

  String _amount = '0';
  String get amount => _amount;

  String _memo = '';
  String get memo => _memo;

  RxString _delegate = ''.obs;
  RxString get delegate => _delegate;

  RxDouble get delegateAmount =>
      double.parse(_delegate.value.replaceAll(",", ".").replaceAll(".", ""))
          .obs;

  final List<double> _fees = [
    Constants.minFee,
    Constants.downFee,
    Constants.averageFee
  ];

  RxInt _selectedFee = 0.obs;
  RxInt get selectedFee => _selectedFee;

  @override
  void onInit() {
    fechtWallet();
    getAmount();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  fechtWallet() async {
    DataWalletHelper.db
        .getUserWakketMapList()
        .then((walletList) => {userWalletItems.value = walletList});
  }

  void onChangeAmount(String text) {
    double temp =
        double.parse(text.replaceAll('.', '').replaceAll(',', '.')) * 1000000;
    _amount = temp.toInt().toString();
  }

  void onChangeMemo(String text) {
    _memo = text;
  }

  void onChangeFee(int i) {
    _selectedFee.value = i;
    update();
  }

  Future<void> staking() async {
    showLoadingDialog();
    String seed = userWalletItems[0]["mnemonic"];
    _mnemonic = seed.substring(1, seed.length - 1).split(', ');

    const String validatorAddress = Constants.VALIDATORADDRESS;

    final networkInfo = NetworkInfo.fromSingleHost(
      bech32Hrp: Constants.CHAIN,
      host: Constants.GRPC,
    );

    final wallet = Wallet.derive(_mnemonic, networkInfo);

    // Compose the transaction fees
    final fee = Fee();
    fee.gasLimit = 200000.toInt64();
    fee.amount.add(
      Coin.create()
        ..amount = _selectedFee.value == 0
            ? Constants.DEFAULTFEE
            : (_fees[_selectedFee.value - 1] * 100000)
                .toString()
                .replaceAll('.', '')
        ..denom = Constants.CHAIN,
    );

    final amount_coin = Coin.create()
      ..denom = Constants.CHAIN
      ..amount = _amount;

    final msgDelegate = MsgUndelegate.create()
      ..delegatorAddress = wallet.bech32Address
      ..validatorAddress = validatorAddress
      ..amount = amount_coin;

    // Build the signer
    final signer = TxSigner.fromNetworkInfo(networkInfo);

    final signedTx = await signer.createAndSign(
      wallet,
      [msgDelegate],
      memo: _memo, // Optional
      fee: fee, // Optional (Default is 200000 gas and empty amount)
    );

    final sender = TxSender.fromNetworkInfo(networkInfo);
    final result = await sender.broadcastTx(
      signedTx,
      mode: BroadcastMode
          .BROADCAST_MODE_BLOCK, // Optional (Default: BroadcastMode.BROADCAST_MODE_SYNC)
    );

    if (result.height > 0) {
      hideLoadingDialog();
      Get.offNamed(AppRoutes.SUCCESSFULTRANSACTION, arguments: result.txhash);
    } else {
      hideLoadingDialog();
      Get.toNamed(AppRoutes.FAILDTRANSACTION);
    }
  }

  void showLoadingDialog() {
    isLoading.value = true;
    Get.dialog(LoadingDialog(), barrierDismissible: false);
  }

  void hideLoadingDialog() {
    isLoading.value = false;
    Get.back();
  }

  void getAmount() {
    _delegate.value = Get.arguments[0]["amount"].value;
  }
}
