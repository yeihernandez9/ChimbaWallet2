import 'package:alan/proto/cosmos/bank/v1beta1/export.dart' as bank;
import 'package:chimba_wallet/app/core/utils/constant/constant.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataWalletHelper.dart';
import 'package:chimba_wallet/app/global_widgets/loading_dialog.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alan/alan.dart';

class SendController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController myTokenController = TextEditingController()
    ..text = 'CHIMBA';
  TextEditingController myAddressController = TextEditingController();

  TextEditingController myAmountController = TextEditingController();

  final listTextTabToggle = ["Low", "Avarege", "High"];

  RxInt tabTextIndexSelected = 1.obs;

  toggle(int index) => tabTextIndexSelected.value = index;

  RxString? _address = ''.obs;
  RxString? get address => _address;

  RxString _token = 'CHIMBA'.obs;
  RxString get token => _token;

  String _amount = '';
  String get amount => _amount;

  String _memo = '';
  String get memo => _memo;

  List<String> _mnemonic = [];
  List<String> get mnemonic => _mnemonic;

  RxList userWalletItems = [].obs;

  String _textMnemonic = "";
  String get textMnemonic => _textMnemonic;

  RxString _amountBalance = ''.obs;
  RxString get amountBalance => _amountBalance;

  RxBool _errorAddress = false.obs;
  RxBool get errorAddress => _errorAddress;

  RxBool _errorAmount = false.obs;
  RxBool get errorAmount => _errorAmount;

  RxBool _statusButton = false.obs;
  RxBool get statusButton => _statusButton;

  String _messageAddress = "";
  String get messageAddress => _messageAddress;

  String _messageAmount = "";
  String get messageAmount => _messageAmount;

  RxString _valor = ''.obs;
  RxString get valor => _valor;

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
    super.onInit();
  }

  @override
  void onReady() {
    getCode();
    super.onReady();
  }

  void onChangeRecipient(String text) {
    _address!.value = text;
    String prefijo = "chimba";

    if (!_address!.value.isEmpty) {
      _errorAddress.value = false;
    } else {
      _errorAddress.value = true;
      _messageAddress = "La direccion no puede ser vacia";
    }

    if (!_address!.value.startsWith(prefijo)) {
      _errorAddress.value = true;
      _messageAddress = "Direccion no valida";
    }
  }

  void onChangeToken(String text) {
    _token.value = text;
  }

  void onChangeAmount(String text) {
    double temp =
        double.parse(text.replaceAll('.', '').replaceAll(',', '.')) * 1000000;
    _amount = temp.toInt().toString();

    if (_amount.isEmpty) {
      _errorAmount.value = true;
    } else {
      _errorAmount.value = false;
    }
  }

  void onChangeMemo(String text) {
    _memo = text;
  }

  void onChangeFee(int i) {
    _selectedFee.value = i;
    update();
  }

  Future<void> sender() async {
    String prefijo = "chimba";
    if (!_address!.value.isEmpty) {
      if (!_address!.value.startsWith(prefijo)) {
        _errorAddress.value = true;
        _messageAddress = "La direccion no valida";
      } else {
        _errorAddress.value = false;
      }
    } else {
      _errorAddress.value = true;
      _messageAddress = "El campo es vacio";
    }

    if (_amount.isEmpty) {
      _errorAmount.value = true;
      _messageAmount = "El campo es vacio";
    } else {
      _errorAmount.value = false;
    }

    // if(int.parse(_amount) >= int.parse(_valor.value)){
    //   _errorAmount.value = true;
    //   _messageAmount = "No tiene balance";
    // }else{
    //    _errorAmount.value = false;
    // }

    if (!_errorAddress.value && !_errorAmount.value) {
      sendTransacction();
    }
  }

  fechtWallet() async {
    DataWalletHelper.db
        .getUserWakketMapList()
        .then((walletList) => {userWalletItems.value = walletList});
  }

  getCode() {
    if (Get.arguments[0].containsKey("amount")) {
      _valor = Get.arguments[0]["amount"];
    }

    if (Get.arguments[0].containsKey("code")) {
      _address!.value = Get.arguments[0]["code"];
      myAddressController.text = Get.arguments[0]["code"];
    }
    update();
  }

  @override
  void dispose() {
    myAddressController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final isLoading = false.obs;

  void showLoadingDialog() {
    isLoading.value = true;
    Get.dialog(LoadingDialog(), barrierDismissible: false);
  }

  void hideLoadingDialog() {
    isLoading.value = false;
    Get.back();
  }

  void getMax() {
    _amountBalance.value = Get.arguments[0]["amount"].value;
    myAmountController.text = _amountBalance.value;
    update();
  }

  goQrScanner() {
    Get.offNamed(AppRoutes.QRSCANNER, arguments: Get.arguments);
    update();
  }

  void sendTransacction() async {
    showLoadingDialog();
    String seed = userWalletItems[0]["mnemonic"];
    _mnemonic = seed.substring(1, seed.length - 1).split(', ');

    final networkInfo = NetworkInfo.fromSingleHost(
      bech32Hrp: Constants.CHAIN,
      host: Constants.GRPC,
    );

    final wallet = Wallet.derive(_mnemonic, networkInfo);

    final addresconver = _address?.value;

    final message = bank.MsgSend.create()
      ..fromAddress = wallet.bech32Address
      ..toAddress = addresconver!;
    message.amount.add(Coin.create()
      ..denom = Constants.CHAIN
      ..amount = _amount);

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

    // Build the signer
    final signer = TxSigner.fromNetworkInfo(networkInfo);

    final signedTx = await signer.createAndSign(
      wallet,
      [message],
      memo: _memo, // Optional
      fee: fee, // Optional (Default is 200000 gas and empty amount)
    );

    final sender = TxSender.fromNetworkInfo(networkInfo);
    final result = await sender.broadcastTx(
      signedTx,
      mode: BroadcastMode
          .BROADCAST_MODE_BLOCK, // Optional (Default: BroadcastMode.BROADCAST_MODE_SYNC)
    );

    // Manejo de errores
    if (result.height > 0) {
      hideLoadingDialog();
      Get.offNamed(AppRoutes.SUCCESSFULTRANSACTION, arguments: result.txhash);
    } else {
      hideLoadingDialog();
      Get.toNamed(AppRoutes.FAILDTRANSACTION);
    }
  }

  goSchedule() {
    Get.offNamed(AppRoutes.BOOK);
  }
}
