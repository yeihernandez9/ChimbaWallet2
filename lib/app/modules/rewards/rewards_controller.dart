import 'package:chimba_wallet/app/core/utils/constant/constant.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataWalletHelper.dart';
import 'package:chimba_wallet/app/global_widgets/loading_dialog.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';

import 'package:alan/alan.dart';
import 'package:alan/proto/cosmos/distribution/v1beta1/export.dart';

class RewardsController extends GetxController {
  final isLoading = false.obs;

  RxList userWalletItems = [].obs;

  List<String> _mnemonic = [];
  List<String> get mnemonic => _mnemonic;

  RxString _reward = ''.obs;
  RxString get reward => _reward;

  final List<double> _fees = [
    Constants.minFee,
    Constants.downFee,
    Constants.averageFee
  ];

  RxInt _selectedFee = 0.obs;
  RxInt get selectedFee => _selectedFee;

  RxDouble get rewardAmount =>
      double.parse(_reward.value.replaceAll(",", ".").replaceAll(".", "")).obs;

  @override
  void onInit() {
    fechtWallet();
    getAmount();
    super.onInit();
  }

  fechtWallet() async {
    DataWalletHelper.db
        .getUserWakketMapList()
        .then((walletList) => {userWalletItems.value = walletList});
  }

  void onChangeFee(int i) {
    _selectedFee.value = i;
    update();
  }

  Future<void> rewards() async {
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

    final msgDelegate = MsgWithdrawDelegatorReward.create()
      ..delegatorAddress = wallet.bech32Address
      ..validatorAddress = validatorAddress;

    // Build the signer
    final signer = TxSigner.fromNetworkInfo(networkInfo);

    final signedTx = await signer.createAndSign(
      wallet,
      [msgDelegate],
      memo: "", // Optional
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
    _reward.value = Get.arguments[0]["amount"].value;
  }
}
