// ignore_for_file: avoid_print, prefer_final_fields, deprecated_member_use, unrelated_type_equality_checks, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, invalid_use_of_protected_member
import 'package:chimba_wallet/app/core/utils/helpers/dataCurrencyHelper.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataSettingHelper.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataWalletHelper.dart';
import 'package:chimba_wallet/app/data/model/createToken.dart';
import 'package:chimba_wallet/app/data/model/observe_verified_wallets.dart';
import 'package:chimba_wallet/app/data/services/auth/local_auth.dart';
import 'package:chimba_wallet/app/core/utils/constant/constant.dart';
import 'package:chimba_wallet/app/data/services/repository/wallet_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chimba_wallet/app/data/model/setting.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:supabase/supabase.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final WalletRepository _requestWallet = Get.put(WalletRepository());
  var nameVersion = "".obs;

  final title = 'Settings'.obs;

  RxList currencies = [].obs;
  RxList userSetting = [].obs;

  RxString _currency = 'COP'.obs;
  RxString get currency => _currency;

  RxString _wallet = 'Mis Billeteras'.obs;
  RxString get wallet => _wallet;

  RxInt _idWallet = 0.obs;
  RxInt get idWallet => _idWallet;

  RxString _address = ''.obs;
  RxString get address => _address;

  RxString _theme = 'Dark'.obs;
  RxString get theme => _theme;

  RxList _dataTheme = [].obs;
  RxList get dataTheme => _dataTheme;

  RxList userWalletItems = [].obs;

  bool _statusButton = false;
  bool get statusButton => _statusButton;

  RxString _password = ''.obs;
  RxString get password => _password;

  RxBool _errorPassword = true.obs;
  RxBool get errorPassword => _errorPassword;

  RxBool _validatedWallet = false.obs;
  RxBool get validatedWallet => _validatedWallet;

  RxBool on = false.obs;

  RxString _tokenAPi = ''.obs;
  RxString get tokenAPi => _tokenAPi;

  final client =
      SupabaseClient(Constants.SUPRABASE_URL, Constants.SUPRABASE_KEY);

  RxList _dataCurrency = [].obs;
  RxList get dataCurrency => _dataCurrency;

  RxBool _addressDb = false.obs;
  RxBool get navigateOpt => _addressDb;

  RxInt selectedRadioCurrency = 1.obs;
  RxInt selectedRadioTheme = 1.obs;

  RxInt _phoneNumberSetting = 0.obs;
  RxInt get PhoneNumberSetting => _phoneNumberSetting;

  RxBool _verifiedWallet = false.obs;
  RxBool get verifiedWallet => _verifiedWallet;

  RxString _nameWallet = ''.obs;
  RxString get nameWallet => _nameWallet;

  String walletId = '';

  String initWalletId = '';

  String _mnemonic = '';
  String get mnemonic => _mnemonic;

  @override
  void onInit() {
    fechtWallet();
    fechtCurrency();
    leerCurrency();
    leerTheme();
    getNameVersion();
    tempInit();
    update();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await fechtUserSetting();
    await getWallet();
    update();
    super.onReady();
  }

  fechtWallet() async {
    DataWalletHelper.db
        .getUserWakketMapList()
        .then((walletList) => {userWalletItems.value = walletList});
  }

  getWallet() {
    for (var element in userWalletItems) {
      if (element["id"] == int.parse(initWalletId)) {
        _address.value = element["address"];
        _nameWallet.value = element["wallet"];
        _idWallet.value = element["id"];
        _mnemonic = element["mnemonic"];
        update();
        break;
      } else if (element["id"] == element["id"]) {
        _address.value = element["address"];
        _nameWallet.value = element["wallet"];
        _idWallet.value = element["id"];
        _mnemonic = element["mnemonic"];
        update();
      }
    }
  }

  fechtUserSetting() async {
    await DataSettingHelper.db
        .getSettingMapList()
        .then((settingList) => {userSetting.value = settingList});
    initWalletId = (userSetting[1]["value_status"]);
    walletId = (userSetting[0]["value_status"]);
    String statusAuth = (walletId);
    _wallet.value = _nameWallet.value;
    _idWallet.value = _idWallet.value;
    _address.value = _address.value;
    _mnemonic = _mnemonic;

    if (statusAuth == "true") {
      on.value = true;
    } else {
      on.value = false;
    }
  }

  tempInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    RequestCreateToken requestCreateToken = await _requestWallet.createToken();
    _tokenAPi.value = requestCreateToken.token;
    walletVerfy();
    // Obtener el último estado guardado
    int? lastSelectedId = prefs.getInt('lastSelectedCurrencyId');
    String? lastSelectedValue = prefs.getString('lastSelectedCurrencyValue');

    lastSelectedId ??= 1;
    lastSelectedValue ??= 'COP';

    // Establecer los valores iniciales
    selectedRadioCurrency.value = lastSelectedId;
    _currency.value = lastSelectedValue;
    update();
  }

  navigationvalidatedWallet() {
    if (_validatedWallet.value == false && _addressDb.value == true) {
      Get.toNamed(AppRoutes.OPT, arguments: _phoneNumberSetting.value);
    }
    if (_validatedWallet.value == false && _addressDb.value == false) {
      Get.toNamed(AppRoutes.PHONE, arguments: _address.value);
    }
  }

  void setSelectedRadioCurrency(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final currencyList = {1: 'COP', 2: 'USD', 3: 'EUR'};

    if (currencyList.containsKey(val)) {
      selectedRadioCurrency.value = val;
      _currency.value = currencyList[val]!;

      var value = _dataCurrency.firstWhere(((element) => element["id"] == val));
      _currency.value = value["name"];

      await prefs.setInt('lastSelectedCurrencyId', selectedRadioCurrency.value);
      await prefs.setString('lastSelectedCurrencyValue', _currency.value);
    }
  }

  walletVerfy() async {
    ObserveVerifidWallet observeVerifidWallet =
        await _requestWallet.getVerifiedWalletRquest(token: _tokenAPi.value);
    observeVerifidWallet.data.forEach((element) {
      if (element.address == _address.value) {
        _addressDb.value = true;
        validatedWallet.value = element.validate;
        _phoneNumberSetting.value = element.phoneNumber;
      }
    });
  }

  getNameVersion() async {
    try {
      final properties =
          await rootBundle.loadString('android/local.properties');
      final getVersion = RegExp(r'flutter.versionName=(.*)');
      final match = getVersion.firstMatch(properties);
      if (match != null) {
        nameVersion.value = match.group(1)!;
      }
    } catch (e) {
      print('Error loading local.properties: $e');
    }
  }

  fechtCurrency() async {
    DataCurrencyHelper.db
        .getCurrencyMapList()
        .then((currencyList) => {currencies.value = currencyList});
  }

  void setSelectedRadioTheme(int val) {
    selectedRadioTheme.value = val;
    var value = _dataTheme.firstWhere(((element) => element["id"] == val));
    _theme.value = value["name"];
  }

  leerCurrency() async {
    var response = await client
        .from("currency")
        .select('*')
        .order('id', ascending: true)
        .execute();

    _dataCurrency.value = response.data as List;
  }

  leerTheme() async {
    var response = await client
        .from("theme")
        .select('*')
        .order('id', ascending: true)
        .execute();

    _dataTheme.value = response.data as List;
  }

  goAccount() {
    Get.toNamed(AppRoutes.ACCOUNT, arguments: _nameWallet.value);
  }

  goBook() {
    Get.toNamed(AppRoutes.BOOK);
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

  void onchangePassword(text) {
    _password.value = text;
  }

  void login() {
    print(_mnemonic);
    if (_password.isEmpty) {
      _errorPassword.value = false;
    } else {
      if (_password.value == userWalletItems[0]["password"]) {
        _errorPassword.value = true;
        Get.toNamed(
          AppRoutes.SHOW_MNEMONIC,
          arguments: _mnemonic
        );
      } else {
        _errorPassword.value = false;
      }
    }
  }

  void delete(int id) {
    try {
      userWalletItems.length == 1
          ? Get.offAllNamed(AppRoutes.SPLASH)
          : Get.offAllNamed(AppRoutes.WALLET_CHANGE);
      DataWalletHelper.db.deleteUserWallet(id);
    } catch (e) {
      print('ERROR DELETE $e');
    }
  }
}
