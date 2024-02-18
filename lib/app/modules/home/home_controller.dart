import 'dart:convert';
import 'dart:io';

import 'package:app_set_id/app_set_id.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataSettingHelper.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataWalletHelper.dart';
import 'package:chimba_wallet/app/data/model/createToken.dart';
import 'package:chimba_wallet/app/data/model/request_available.dart';
import 'package:chimba_wallet/app/data/model/request_governance.dart';
import 'package:chimba_wallet/app/data/model/request_token_firebase.dart';
import 'package:chimba_wallet/app/data/provider/push_notification.dart';
import 'package:chimba_wallet/app/data/services/repository/wallet_repository.dart';
import 'package:chimba_wallet/app/modules/setting/setting_controller.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:cron/cron.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../data/model/request_delegate.dart';
import '../../data/model/request_reward.dart';
import '../../data/model/request_type_currency.dart';
import '../../data/model/request_unbonding.dart';
import '../../data/model/response_get_device.dart';

class HomeController extends GetxController {
  final WalletRepository _requestWallet = Get.put(WalletRepository());
  final settingController = Get.find<SettingController>();
  final cron = Cron();
  final MethodChannel _methodChannel =
      const MethodChannel("samples.flutter.io/battery");

  final String _batteryLevel = 'Unknown battery level.';
  final deviceInfoPlugin = DeviceInfoPlugin();

  RxList userWalletItems = [].obs;

  List<RequestGovernance> _dataGovernance = [];
  List<RequestGovernance> get dataGovernance => _dataGovernance;

  List<RequestGovernance> _statusVoting = [];
  List<RequestGovernance> get statusVoting => _statusVoting;

  int _counter = 0;
  int get couter => _counter;

  String _address = '';
  String get address => _address;

  String _nameWallet = '';
  String get nameWallet => _nameWallet;

  final List<String> _mnemonic = [];
  List<String> get mnemonic => _mnemonic;

  final RxString _balance = '0'.obs;
  RxString get balance => _balance;

  final RxString _balancePesos = '0'.obs;
  RxString get balancePesos => _balancePesos;

  final RxString _available = '0'.obs;
  RxString get available => _available;

  final RxString _delegate = '0'.obs;
  RxString get delegate => _delegate;

  final RxString _unbonding = '0'.obs;
  RxString get unbonding => _unbonding;

  final RxString _reward = '0'.obs;
  RxString get reward => _reward;

  String scannerQrCode = '';

  RxList userSetting = [].obs;

  String walletId = '';

  final RxBool _status = false.obs;
  RxBool get status => _status;

  RxString get _currency => settingController.currency;
  RxString get typeCurrency => _currency;

  @override
  void onInit() async {
    await initializeDateFormatting('es_ES');
    getUserWalletItems();
    update();
    push();
    super.onInit();
  }

  getUserWalletItems() async {
    DataWalletHelper.db
        .getUserWakketMapList()
        .then((walletList) => {userWalletItems.value = walletList});
  }

  @override
  Future<void> onReady() async {
    await fechtUserSetting();
    await getWallet();
    getGovernance();

    cron.schedule(Schedule.parse('*/30 * * * * *'), () async {
      getBalance();
    });

    getTokenFirebase();

    update();
    // TODO: implement onReady
    super.onReady();
  }

  void increment() {
    _counter++;
    update();
  }

  getWallet() {
    for (var element in userWalletItems) {
      if (element["id"] == int.parse(walletId)) {
        _address = element["address"];
        _nameWallet = element["wallet"];
        update();
        break;
      } else if (element["id"] == element["id"]) {
        _address = element["address"];
        _nameWallet = element["wallet"];
        update();
      }
    }

    getBalance();

    update();
  }

  Future<void> getBalance() async {
    // double typeMoney = await getConvertMoney();
    // _typeMoney.value = convertMoney(typeMoney.toStringAsFixed(2));

    double available = await getAvailable();
    _available.value = convertMoney(available.toStringAsFixed(2));

    double delegate = await getDelegate();
    _delegate.value = convertMoney(delegate.toStringAsFixed(2));

    double unbonding = await getUnbonding();
    _unbonding.value = convertMoney(unbonding.toStringAsFixed(2));

    double reward = await getReward();
    _reward.value = convertMoney(reward.toStringAsFixed(2));

    double balance = available + delegate + unbonding + reward;
    _balance.value = convertMoney(balance.toStringAsFixed(2));
    double balancePesos = balance * 5;

    // ignore: unrelated_type_equality_checks
    if (_currency == 'COP') {
      _balancePesos.value = convertMoney(balancePesos.toStringAsFixed(2));
    }
    // ignore: unrelated_type_equality_checks
    if (_currency == 'USD') {
      double temp = await getConvertMoney();
      balancePesos = balancePesos / temp;
      _balancePesos.value = convertMoney(balancePesos.toStringAsFixed(2));
    }
    // ignore: unrelated_type_equality_checks
    if (_currency == 'EUR') {
      double temp = await getConvertMoney();
      balancePesos = balancePesos / temp;
      _balancePesos.value = convertMoney(balancePesos.toStringAsFixed(2));
    }

    if (available > 0) {
      _status.value = true;
    } else {
      _status.value = false;
    }

    update();
  }

  Future<double> getConvertMoney() async {
    RequestTypeMoney requestConvertMoney =
        await _requestWallet.getConvertMoneyRequest(typeMoney: _currency.value);
    return (double.parse(requestConvertMoney.amount));
  }

  Future<double> getAvailable() async {
    RequestAvailable requestAvailable =
        await _requestWallet.getAvailableRequest(address: _address);
    return (double.parse(requestAvailable.amount) / 1000000);
  }

  Future<double> getDelegate() async {
    RequestDelegate requestDelegate =
        await _requestWallet.getDelegateRequest(address: _address);
    return (double.parse(requestDelegate.amount) / 1000000);
  }

  Future<double> getUnbonding() async {
    List<RequestUnbonding> requestDelegate =
        await _requestWallet.getUnbondingRequest(address: _address);

    double acumBalance = 0;
    requestDelegate.forEach((element) {
      acumBalance += double.parse(element.balance);
    });
    return (acumBalance / 1000000);
  }

  Future<double> getReward() async {
    RequestReward requestReward =
        await _requestWallet.getRewardRequest(address: _address);
    return (double.parse(requestReward.amount) / 1000000);
  }

  Future<void> getGovernance() async {
    _statusVoting = await _requestWallet.getGovernanceRequest();
    _dataGovernance =
        _statusVoting.where((governance) => governance.status == 2).toList();

    update();
  }

  goStakingDashboard() {
    Get.toNamed(AppRoutes.STAKING_DASHBOARD);
  }

  goGovernance() {
    Get.toNamed(AppRoutes.GOVERNANCE, arguments: _statusVoting);
  }

  goSend() {
    Get.toNamed(AppRoutes.SEND, arguments: [
      {"address": _address, "amount": _available}
    ]);
  }

  goStaking() {
    Get.toNamed(AppRoutes.STAKING, arguments: [
      {"amount": _available}
    ]);
  }

  goRewards() {
    Get.toNamed(AppRoutes.REWARDS, arguments: [
      {"amount": _reward}
    ]);
  }

  goUnstaking() {
    Get.toNamed(AppRoutes.UNSTAKING, arguments: [
      {"amount": _delegate}
    ]);
  }

  goStatusGovenance(String? id) {
    Get.toNamed(AppRoutes.PROPOSAL, arguments: id);
  }

  Future<void> getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await _methodChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    update();
  }

  goQrScanner() {
    Get.toNamed(AppRoutes.QRSCANNER, arguments: [
      {"address": _address, "amount": _balance}
    ]);
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Share Address'.tr,
      text: _address,
      linkUrl: 'https://chimba.ooo/',
      chooserTitle: 'Share Address'.tr,
    );
  }

  fechtUserSetting() async {
    await DataSettingHelper.db
        .getSettingMapList()
        .then((settingList) => {userSetting.value = settingList});
    walletId = (userSetting[1]["value_status"]);
  }

  String convertMoney(String monto) {
    // Reemplaza las comas por puntos y elimina el signo de dólar
    monto = monto.replaceAll(',', '.').replaceAll('\$', '');

    // Divide el monto en dos partes: la entera y la decimal
    List<String> partes = monto.split('.');

    // Agrega el separador de miles en la parte entera
    partes[0] = partes[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );

    // Concatena las partes y agrega el símbolo de la moneda al final
    return partes.join(',');
  }

  push() {
    final pushProvider = new PushNotification();
    pushProvider.initNotification();
    pushProvider.message.listen((event) {
      Get.offNamed(AppRoutes.NOTIFICATION, arguments: event);
    });
  }

  getTokenFirebase() async {
    final pushProvider = new PushNotification();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    RequestCreateToken requestCreateToken = await _requestWallet.createToken();

    String? tokenFirebase = await pushProvider.getToken();

    if (Platform.isIOS) {
      String deviceId = deviceInfo.data['identifierForVendor'];
      String ios = 'iOS';
      await validatePlatform(
          tokenFirebase, requestCreateToken.token, deviceId, ios);
    }

    if (Platform.isAndroid) {
      String deviceId = await AppSetId().getIdentifier() ?? '';
      String ios = 'Android';
      await validatePlatform(
          tokenFirebase, requestCreateToken.token, deviceId, ios);
    }
  }

  updateTokenFirebase(ios, tokenFirebase, deviceId, tokenAuth, idDevice) async {
    RequestTokenFirebase pachTokenFirebase =
        await _requestWallet.updateTokenFirebase(
            oS: ios,
            tokenFirebase: tokenFirebase,
            deviceID: deviceId,
            token: tokenAuth,
            uid: idDevice);
    print(pachTokenFirebase);
  }

  validatePlatform(
      String? tokenFirebase, String token, String deviceId, ios) async {
    try {
      String getTokenFirebase =
          await _requestWallet.getTokenFirebase(deviceId: deviceId);
      GetDevice getDevice = GetDevice.fromJson(jsonDecode(getTokenFirebase));
      if (getDevice.deviceID != null || getDevice.deviceID != "") {
        String? idDevice = getDevice.sId;
        var response = await updateTokenFirebase(
            ios, tokenFirebase!, deviceId, token, idDevice);
      }
    } catch (e) {
      RequestTokenFirebase addTokenFirebase =
          await _requestWallet.addTokenFirebases(
              deviceId: deviceId,
              os: ios,
              tokenFirebase: tokenFirebase!,
              tokenTransaction: token);
    }
  }
}
